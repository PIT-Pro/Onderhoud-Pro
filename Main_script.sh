#!/bin/bash
loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`
#
/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="PIT Pro Onderhoud" description="PIT Pro onderhoud gaat starten. Je computer kan trager aanvoelen, maar je kunt wel doorwerken." closeLabel="Oké" timeout="59" && proceed=1
#

if [ -e Users/Public/maintenance_log.txt ]
then
    echo "maintenance_log.txt exists, writing output to file.."
else
    touch Users/Public/maintenance_log.txt
fi

echo "Checking MBBR.." | tee Users/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/MBBR_check.sh)" >> Users/Public/maintenance_log.txt
echo "Purging caches.." | tee Users/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/purge_cache.sh)" >> Users/Public/maintenance_log.txt
echo "Clearing browser caches.." | tee Users/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/clear_browser_caches.sh)" >> Users/Public/maintenance_log.txt
echo "Checking uptime.." | tee Users/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/uptime.sh)" >> Users/Public/maintenance_log.txt

pitproCareLastTime="$(/usr/bin/stat -f "%Sm" -t "%Y%m%d" "/Applications/Utilities/Maintenance.app")" #get the last time PITPro Care has run
currentDate="$(/bin/date +%Y%m%d)" #get the current date

echo $pitproCareLastTime >> Users/Public/maintenance_log.txt
echo $currentDate >> Users/Public/maintenance_log.txt

/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="PIT Pro Onderhoud" action=notify description="PIT Pro onderhoud is klaar!" closeLabel="Oké"

exit 0