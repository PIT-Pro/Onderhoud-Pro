#!/bin/bash
#
# Uptime to check
limit="7"
# Get uptime.
days=(`uptime | awk '{ print $4 }' | sed 's/,//g'`)
if [ "$days" -gt "$limit" ]; then
    echo "Machine needs reboot" 
    /Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="Herstart aanbevolen" description="Je Mac is al $days dagen niet opnieuw opgestart. Herstarten is aanbevolen." acceptLabel="Herstart" closeLabel="Niet nu" timeout="60" && sudo -u $username osascript -e 'tell app "loginwindow" to Â«event aevtrrstÂ»' || echo "Restart not accepted by user."
else
    echo "Machine does not need to reboot, uptime less than $limit days"
fi
# Uptime check finished