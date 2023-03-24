#!/bin/bash

#Variables
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }')
LOGFILE=/Library/Addigy/PIT\ Pro/Onderhoud-Pro_log.txt
currentDate=$(date +%Y/%m/%d\ %H:%M:%S)


#Functions
check_log(){
if [ -e "$LOGFILE" ];
then
    echo "Onderhoud-Pro_log.txt exists, writing output to file.."
else
    echo "Onderhoud-Pro_log.txt does not exist, creating file.."
    touch "/Library/Addigy/PIT Pro/Onderhoud-Pro_log.txt"
fi
}

swiftDialog(){
#Run swiftDialog
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/dialog.sh)"
}

purge_caches(){
#Run purge of caches
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/caches.sh)"
}

kickstart_softwareupdate(){
#Kickstart Softwareupdated
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/softwareupdate.sh)"
}

reboot_mac(){
    shutdown -r now
}

check_log
swiftDialog
kickstart_softwareupdate
sleep 5
reboot_mac

exit 0