#!/bin/bash

#zoek ingelogde user
loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`
#verwijder safari cache
rm -R /Users/$loggedInUser/Library/Caches/com.apple.Safari/WebKitCache/
#verwijder chrome cache
rm -R ~/Library/Caches/Google/Chrome/Default/Cache
rm -R ~/Library/Caches/Google/Chrome/Default/Code\ Cache
#verwijder edge cache
rm -R /Users/$loggedInUser/Library/Caches/Microsoft\ Edge/Default/Cache/
rm -R /Users/$loggedInUser/Library/Caches/Microsoft\ Edge/Default/Code\ Cache/
