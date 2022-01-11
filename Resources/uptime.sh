#!/bin/bash
#

/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="Herstart aanbevolen" description="Herstarten is aanbevolen." acceptLabel="Herstart" closeLabel="Niet nu" timeout="60" && sudo -u $username osascript -e 'tell app "loginwindow" to Â«event aevtrrstÂ»' || echo "Restart not accepted by user."
fi
# Uptime check finished