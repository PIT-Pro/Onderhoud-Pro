#!/bin/bash

LOGFILE=/Library/Addigy/PIT\ Pro/maintenance_log.txt

# Kill any Apple Silicon downloads
if pgrep BrainService; then
    pkill BrainService
fi

# Remove temporary files
rm -f /Library/Preferences/com.apple.SoftwareUpdate.plist

# Kill and restart Software Update
while launchctl kill 9 system/com.apple.softwareupdated; do
    sleep 1
done

launchctl kickstart system/com.apple.softwareupdated
    sleep 1
mv /Library/Receipts/InstallHistory.plist /Library/Receipts/InstallHistory.plist.old
    sleep 3
exit 0