#!/bin/bash
loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`
#
/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="PIT Pro Onderhoud" description="PIT Pro onderhoud gaat starten. Je computer kan trager aanvoelen, maar je kunt wel doorwerken." closeLabel="Oké" timeout="59" && proceed=1
#

if [ -e /$loggedinUser/Public/maintenance_log.txt ]
then
    echo "maintenance_log.txt exists, writing output to file.."
else
    touch $loggedInUser/Public/maintenance_log.txt
fi

echo "Checking MBBR.." | tee $loggedInUser/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/MBBR_check.sh)" 1> /$loggedinUser/Public/maintenance_log.txt
echo "Purging caches.." | tee $loggedInUser/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/purge_cache.sh)" 1> /$loggedinUser/Public/maintenance_log.txt
echo "Clearing browser caches.." | tee $loggedInUser/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/clear_browser_caches.sh)" 1> /$loggedinUser/Public/maintenance_log.txt
echo "Checking uptime.." | tee $loggedInUser/Public/maintenance_log.txt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Resources/uptime.sh)" 1> /$loggedinUser/Public/maintenance_log.txt

pitproCareLastTime="$(/usr/bin/stat -f "%Sm" -t "%Y%m%d" "/Applications/Utilities/Maintenance.app")" #get the last time PITPro Care has run
currentDate="$(/bin/date +%Y%m%d)" #get the current date

echo $pitproCareLastTime > $loggedInUser/Public/maintenance_log.txt
echo $currentDate > $loggedInUser/Public/maintenance_log.txt

/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="PIT Pro Onderhoud" action=notify description="PIT Pro onderhoud is klaar!" closeLabel="Oké"

exit 0