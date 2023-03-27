#!/bin/bash

Variables
dialog=/usr/local/bin/dialog

runDialog(){
$dialog --title "Onderhoud Pro" --titlefont "size=20" --icon "https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Files/logo.png" --overlayicon caution --ontop --small --infobox "PIT Pro B.V. \n - Je kunt ons bereiken via: support@pitpro.nl \n - Of voor spoed: 020-2611450" --messagefont "size=14" --message "Deze app verhelpt de volgende situaties: \n - Problemen met synchronisatie van Cloud opslag (Google Drive, Dropbox) \n\n - Problemen met je internet browser (Safari, Chrome, Edge) \n - Problemen met het updaten/upgrade van je Mac."
}

runDialog