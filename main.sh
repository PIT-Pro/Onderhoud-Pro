#!/bin/bash

#Variables
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }')
LOGFILE=/Library/Addigy/PIT\ Pro/Onderhoud-Pro_log.txt
currentDate=$(date +%Y/%m/%d\ %H:%M:%S)

if [ -e "$LOGFILE" ];
then
    echo "Onderhoud-Pro_log.txt exists, writing output to file.."
else
    echo "Onderhoud-Pro_log.txt does not exist, creating file.."
    touch "/Library/Addigy/PIT Pro/Onderhoud-Pro_log.txt"
fi

#Run Dialog
dialog --jsonfile "https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/dialog.json"

echo "Purging caches.."
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Files/purge_cache.sh)"

echo "Kickstarting softwareupdated"
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Files/softwareupdated.sh)" >> "$LOGFILE"

#/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="Herstart aanbevolen" description="Restarting your Mac is highly recommended. Save your work before clicking on Restart." acceptLabel="Restart" closeLabel="Not now" && sudo -u "$loggedInUser" osascript -e 'tell app "loginwindow" to Â«event aevtrrstÂ»' || echo "Restart not accepted by user." >> "$LOGFILE"
echo "END OF SCRIPT"

exit 0