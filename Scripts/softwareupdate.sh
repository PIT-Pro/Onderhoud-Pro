#!/bin/bash

#Variables
LOGFILE=/Library/Addigy/PIT\ Pro/maintenance_log.txt

#Functions
kill_brainservice(){
  if pgrep BrainService; then
    pkill BrainService
fi  
}

remove_temp_files(){
    rm -rf /Library/Preferences/com.apple.SoftwareUpdate.plist
}

kill_restart_service(){
    while launchctl kill 9 system/com.apple.softwareupdated; do
        sleep 1
    done
}

launch_service_move_old_files(){
    launchctl kickstart system/com.apple.softwareupdated
        sleep 1
    mv /Library/Receipts/InstallHistory.plist /Library/Receipts/InstallHistory.plist.old
        sleep 3
    exit 0
}

#Run functions
kill_brainservice
remove_temp_files
kill_restart_service
launch_service_move_old_files