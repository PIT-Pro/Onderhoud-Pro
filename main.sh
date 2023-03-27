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

#Run swiftDialog
echo "Running swiftDialog.."
swiftDialog(){
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/dialog.sh)"
}

#Run purge of caches
echo "Running purge.."
purge_caches(){
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/caches.sh)"
}

#Kickstart Softwareupdated
echo "kickstart_softwareupdated.."
kickstart_softwareupdate(){
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/softwareupdate.sh)"
}

#..reboot Mac
echo "Checking for reboot.."
check_reboot_mac(){
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/reboot.sh)"
}

#self-destruct script for continuous operation from Self-Service
echo "Selfdestructing from ansible.."
self-destruct(){
    rm -rf "/Library/Addigy/ansible/packages/Onderhoud Pro (1.0)/main.sh"
}

#Run functions
check_log
swiftDialog
purge_caches
kickstart_softwareupdate
sleep 5
check_reboot_mac
self-destruct