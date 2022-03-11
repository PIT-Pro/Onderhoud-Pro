#!/bin/bash

#zoek ingelogde user
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )#verwijder safari cache
rm -R /Users/$loggedInUser/Library/Caches/com.apple.Safari/WebKitCache/
#verwijder chrome cache
rm -R ~/Library/Caches/Google/Chrome/Default/Cache
rm -R ~/Library/Caches/Google/Chrome/Default/Code\ Cache
#verwijder edge cache
rm -R /Users/$loggedInUser/Library/Caches/Microsoft\ Edge/Default/Cache/
rm -R /Users/$loggedInUser/Library/Caches/Microsoft\ Edge/Default/Code\ Cache/
