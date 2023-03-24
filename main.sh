#!/bin/bash

#Onderhoud Pro, PIT Pro B.V
#Versie 1.0

#Variables
LOGFILE=/Library/Addigy/PIT\ Pro/Onderhoud-Pro_log.txt

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
    shutdown -r
    exit 0
}

self-destruct(){
    rm -rf "/Library/Addigy/Onderhoud Pro (1.0)"
}

#Run functions
check_log
swiftDialog
purge_caches
kickstart_softwareupdate
sleep 5
self-destruct
reboot_mac