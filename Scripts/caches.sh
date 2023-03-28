#!/bin/bash

#Variables
loggedInUser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
googleChrome="/Applications/Google Chrome.app"
microsoftEdge="/Applications/Microsoft Edge.app"
microsoftOffice="/Applications/Microsoft Excel.app"
googleDrive="/Applications/Google Drive.app"
dropbox="/Applications/Dropbox.app"

#Close all running apps

close_all_apps(){
osascript <<EOD
tell application "System Events" to set quitapps to name of every application process whose visible is true and name is not "Finder"
repeat with closeall in quitapps
quit application closeall
end repeat
EOD
}

#Functions
remove_chrome_cache() {
    if [[ -d $googleChrome ]] ; then
        echo "removing Chrome caches.."
        rm -rf "/Users/$loggedInUser/Library/Caches/Google/Chrome/Default/Cache"
        rm -rf "/Users/$loggedInUser/Library/Caches/Google/Chrome/Default/Code Cache"
    else
        echo "Google Chrome not installed"
    fi
}
remove_edge_cache() {
    if [[ -d $microsoftEdge ]]; then
        echo "removing edge caches.."
        rm -rf "/Users/$loggedInUser/Library/Caches/Microsoft Edge/Default/Cache"
        rm -rf "/Users/$loggedInUser/Library/Caches/Microsoft Edge/Default/Code Cache"
    else
        echo "Microsoft Edge not installed"
    fi
}

remove_saved_state_macOS_applications(){
    echo "removing saved states.."
    rm -rf "/Users/$loggedInUser/Library/Saved Application State/" 
}

remove_Microsoft_365_caches(){
    if [[ -d $microsoftOffice ]]; then
        echo "removing 365 caches.."
        rm -rf "/Users/$loggedInUser/Library/Containers/com.Microsoft.OsfWebHost/Data"
        rm -rf "/Users/$loggedInUser/Library/Containers/com.microsoft.Office365ServiceV2/Data/Caches/com.microsoft.Office365ServiceV2"
        rm -rf "/Library/Containers/com.microsoft.Excel/Data/Library/Caches"
        rm -rf "/Library/Containers/com.microsoft.Word/Data/Library/Caches"
        rm -rf "/Library/Containers/com.microsoft.Powerpoint/Data/Library/Caches"
    else
        echo "Microsoft 365 not installed"
    fi
}

remove_googledrive_cache(){
    if [[ -d $googleDrive ]]; then
        echo "removing Drive caches.."
        rm -rf "/Users/$loggedInUser//Library/Application Support/Google/DriveFS"
    else
        echo 'Google Drive not installed'
    fi
}

remove_dropbox_cache(){
        if [[ -d $dropbox ]]; then
            echo "removing Dropbox caches.."
            rm -rf "/Users/$loggedInUser/Dropbox/.dropbox.cache"
        else
            echo "Dropbox not installed"
        fi
}

#Run functions
close_all_apps
remove_chrome_cache
remove_edge_cache
remove_saved_state_macOS_applications
remove_googledrive_cache
remove_dropbox_cache
remove_Microsoft_365_caches
