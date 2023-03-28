#!/bin/bash

#Variables
dialog=/usr/local/bin/dialog

runDialog(){
$dialog --title "Onderhoud Pro" --titlefont "size=20" --icon "https://raw.githubusercontent.com/PIT-Pro/Onderhoud-Pro/main/Files/logo.png" --overlayicon caution --ontop --small --infobox "PIT Pro B.V. \n - Je kunt ons bereiken via: support@pitpro.nl \n - Of voor spoed: 020-2611450" --messagefont "size=14" --message "Onderhoud Pro is klaar met de werkzaamheden. Vergeet niet je Mac te herstarten om de wijzigingen succesvol door te voeren."
}

runDialog