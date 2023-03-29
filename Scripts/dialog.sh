#!/bin/bash

#Variables
dialog=/usr/local/bin/dialog

runDialog(){
$dialog --title "Onderhoud Pro" --titlefont "size=20" --icon "https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Files/logo.png" --overlayicon caution --progress 8 --ontop --small --height 500 --infobox "PIT Pro B.V. \n - Je kunt ons bereiken via: support@pitpro.nl \n - Of voor spoed: 020-2611450" --messagefont "size=14" --message "Deze app verhelpt mogelijk de volgende situaties: \n - Problemen met synchronisatie van Cloud opslag (Google Drive, Dropbox) \n\n - Problemen met je internet browser (Safari, Chrome, Edge) \n - Problemen met het updaten/upgrade van je Mac. \n - Problemen met Microsoft 365 (Word, Excel, Outlook, Powerpoint, Teams) \n\n Let op: Applicaties worden bij het uitvoeren van het programma in de achtergrond uitgezet. Sla daarom nu je Word, Excel etc. bestanden op."
}

runDialog