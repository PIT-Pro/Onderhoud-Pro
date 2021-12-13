#!/bin/bash

# Uptime to check
limit="21"

# Get uptime.
days=$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" " }')

# Get logged in user.
username=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`

if [ "$days" -gt "$limit" ]; then
    echo "Machine needs reboot" 
    /Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="Herstart aanbevolen" description="Je Mac is al $days dagen niet opnieuw opgestart. Herstarten is aanbevolen." acceptLabel="Herstart" closeLabel="Niet nu" timeout="60" && sudo -u $username osascript -e 'tell app "loginwindow" to Â«event aevtrrstÂ»' || echo "Restart not accepted by user."

else
    echo "Machine does not need to reboot, uptime less than $limit days"
fi
# Uptime check finished