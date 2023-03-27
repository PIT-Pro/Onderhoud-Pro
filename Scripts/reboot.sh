#!/bin/bash

#Variables
dialog="/usr/local/bin/dialog"
dialogTitle="Onderhoud Pro - Een herstart is nodig"
loggedInUser=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')
minDays=7
maxDays=15
days=$(uptime | awk '{ print $4 }' | sed 's/,//g')
num=$(uptime | awk '{ print $3 }')

check_uptime(){
if [ $loggedInUser != "root" ]; then
	if [ $days = "days" ]; then	
		if [ $num -gt $minDays ]; then		
			if [ $num -gt $maxDays ]; then			
				message="Je Mac is al **$maxDays** dagen niet herstart. Dit is van belang om een soepele werk ervaring te kunnen garanderen."		
				$dialog --small --height 220 --position topright --title "$dialogTitle" --titlefont size=20 --icon "https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Files/logo.png"  --message "$message" --overlayicon caution --button1text "Herstart" --button1shellaction "osascript -e 'tell app "System Events" to shut down'" --button2text "OK"


			else
				message="Je Mac is al $num dagen niet herstart. Dit is van belang om een soepele werk ervaring te kunnen garanderen."
				$dialog --small --height 220 --position topright --title "$dialogTitle" --titlefont size=20 --icon "https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Files/logo.png"  --message "$message" --overlayicon caution --button1text "Herstart" --button1shellaction "osascript -e 'tell app "System Events" to shut down'" --button2text "OK"
			fi
		fi
	fi
fi
exit 0 
}

check_uptime
