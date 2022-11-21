#!/bin/bash
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }')

/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="PIT Pro Maintenance" description="PIT Pro onderhoud gaat starten. Je computer kan tijdelijk traag aanvoelen." closeLabel="Oké"  && proceed=1

LOGFILE=/Library/Addigy/PIT\ Pro/maintenance_log.txt
currentDate=$(date +%Y/%m/%d\ %H:%M:%S)

if [ -e "$LOGFILE" ];
then
    echo "maintenance_log.txt exists, writing output to file.."
else
    echo "maintenance_log.txt does not exist, creating file.."
    touch /Library/Addigy/PIT\ Pro/maintenance_log.txt
fi

echo "START OF SCRIPT" >> "$LOGFILE"

echo "$currentDate" >> "$LOGFILE"

echo "Checking MBBR.." >> "$LOGFILE"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Files/MBBR_check.sh)" >> "$LOGFILE"
echo "Purging caches.." >> "$LOGFILE"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Files/purge_cache.sh)"
echo "Clearing browser caches.." >> "$LOGFILE"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Files/clear_browser_caches.sh)" | tee -a "$LOGFILE"
echo "Kickstarting softwareupdated" >> "$LOGFILE"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Maintenance/main/Files/softwareupdated.sh)" | tee -a "$LOGFILE"

/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="Herstart aanbevolen" description="Herstarten is aanbevolen. Sla belangrijke data op voordat je op Herstart klikt." acceptLabel="Herstart" closeLabel="Niet nu" && sudo -u "$loggedInUser" osascript -e 'tell app "loginwindow" to Â«event aevtrrstÂ»' || echo "Restart not accepted by user." | tee -a "$LOGFILE"
echo "END OF SCRIPT" >> "$LOGFILE"

exit 0