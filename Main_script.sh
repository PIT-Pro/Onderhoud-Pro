#!/bin/bash

/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="PIT Pro Onderhoud" description="PIT Pro onderhoud gaat starten. Je computer kan trager aanvoelen, maar je kunt wel doorwerken." closeLabel="Oké" timeout="59" && proceed=1

source /Applications/Utilities/Maintenance.app/Contents/Resources/MBBR_check.sh &
source /Applications/Utilities/Maintenance.app/Contents/Resources/purge_cache.sh &
source /Applications/Utilities/Maintenance.app/Contents/Resources/clear_browser_caches.sh &
source /Applications/Utilities/Maintenance.app/Contents/Resources/uptime.sh &

pitproCareLastTime="$(/usr/bin/stat -f "%Sm" -t "%Y%m%d" "/Applications/Utilities/Maintenance.app")" #get the last time PITPro Care has run
currentDate="$(/bin/date +%Y%m%d)" #get the current date

loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`

echo $pitproCareLastTime > ~/$loggedInUser/Public/maintenance_log.txt
echo $currentDate > ~/$loggedInUser/Public/maintenance_log.txt

/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="PIT Pro Onderhoud" action=notify description="PIT Pro onderhoud is klaar!" closeLabel="Oké"

exit 0