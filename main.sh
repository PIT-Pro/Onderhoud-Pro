#!/bin/bash

#Onderhoud Pro, PIT Pro B.V
#Versie 1.0

#Variables
LOGFILE=/Library/Addigy/PIT\ Pro/Onderhoud-Pro_log.txt

#Functions

#Installs swiftDialog if not found
dialogCheck(){
  # Get the URL of the latest PKG From the Dialog GitHub repo
  dialogURL=$(curl --silent --fail "https://api.github.com/repos/bartreardon/swiftDialog/releases/latest" | awk -F '"' "/browser_download_url/ && /pkg\"/ { print \$4; exit }")
  # Expected Team ID of the downloaded PKG
  expectedDialogTeamID="PWA5E9TQ59"

  # Check for Dialog and install if not found
  if [ ! -e "/Library/Application Support/Dialog/Dialog.app" ]; then
    echo "Dialog not found. Installing..."
    # Create temporary working directory
    workDirectory=$( /usr/bin/basename "$0" )
    tempDirectory=$( /usr/bin/mktemp -d "/private/tmp/$workDirectory.XXXXXX" )
    # Download the installer package
    /usr/bin/curl --location --silent "$dialogURL" -o "$tempDirectory/Dialog.pkg"
    # Verify the download
    teamID=$(/usr/sbin/spctl -a -vv -t install "$tempDirectory/Dialog.pkg" 2>&1 | awk '/origin=/ {print $NF }' | tr -d '()')
    # Install the package if Team ID validates
    if [ "$expectedDialogTeamID" = "$teamID" ] || [ "$expectedDialogTeamID" = "" ]; then
      /usr/sbin/installer -pkg "$tempDirectory/Dialog.pkg" -target /
      echo "Dialog Team ID verification failed."
      exit 1
    fi
    # Remove the temporary working directory when done
    /bin/rm -Rf "$tempDirectory"  
  else echo "Dialog found. Proceeding..."
  fi
}

check_log(){
    if [ -e "$LOGFILE" ];
then
    echo "Onderhoud-Pro_log.txt exists, writing output to file.."
    exec > >(tee $LOGFILE) 2>&1
    echo "==> $(date "+%Y-%m-%d %H:%M:%S")"
else
    echo "Onderhoud-Pro_log.txt does not exist, creating file.."
    touch "/Library/Addigy/PIT Pro/Onderhoud-Pro_log.txt"
    exec > >(tee $LOGFILE) 2>&1
    echo "==> $(date "+%Y-%m-%d %H:%M:%S")" 
fi
}

#Run swiftDialog
swiftDialog(){
    echo "Running swiftDialog.."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/dialog.sh)"
}

#Run purge of caches
purge_caches(){
    echo "Running purge.."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/caches.sh)"
}

#Kickstart Softwareupdated
kickstart_softwareupdate(){
    echo "kickstart_softwareupdated.."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/softwareupdate.sh)"
}

#..reboot Mac
check_reboot_mac(){
    echo "Checking for reboot.."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Scripts/reboot.sh)"
}

#self-destruct script for continuous operation from Self-Service
self-destruct(){
    echo "Selfdestructing from ansible.."
    rm -rf "/Library/Addigy/ansible/packages/Onderhoud Pro (1.0)/main.sh"
}

#Run functions
dialogCheck
check_log
swiftDialog
purge_caches
kickstart_softwareupdate
sleep 5
check_reboot_mac
self-destruct