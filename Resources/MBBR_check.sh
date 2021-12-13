#!/bin/bash
# MBBR started!

set -e
log_path="/Library/Addigy/logs/mbbr"
timestamp=$(date +"%Y-%m-%d-%H-%M")
log_name="${log_path}/scan-${timestamp}.log"

# Check for mbbr installation
if [ !  -f /usr/local/bin/mbbr ]; then
echo "Error: mbbr bin file not found. Make sure Malwarebytes Breach Remediation is installed." 1>&2
exit 1

else
# Create log directory if it does not exist.
if [ ! -d "$log_path" ]; then
mkdir "$log_path"
fi

# Re-license MBBR because... Malwarebytes.
/Library/Addigy/addigy-mbbr -license > /dev/null

# Update and scan.
/usr/local/bin/mbbr update >> "$log_name" 2>&1
echo "Scanning to $log_name..."
/usr/local/bin/mbbr scan -remove -noreboot >> "$log_name" 2>&1

# Parse the output
if [ ! -f $log_name ]; then
echo "Error: log file wasn't found. There appears to be a problem with your mbbr binary." 1>&2
exit 1

else
# Check mbbr output.
status=$(grep "Files detected:" < "${log_name}" || true)
files=$(grep -E 'Removing|Quarantining' < "${log_name}" || true)
license=$(grep "Error: License key invalid." < "${log_name}" || true)

# Check for Malwarebytes Invalid License Error.
if [[ "$license" != "" ]]; then
echo "Error: License key invalid."
exit 1
fi

echo $status
if [[ "$status" != "" ]]; then
echo "MALWARE DETECTED!" 1>&2

# Push ticket with malware statistics.
curl -X POST https://$(/Library/Addigy/go-agent agent realm).addigy.com/submit_ticket/ -H 'content-type: application/json' -d "{\"agentid\": \"$(/Library/Addigy/go-agent agent agentid)\", \"orgid\":\"$(/Library/Addigy/go-agent agent orgid)\", \"name\":\"MBBR\", \"description\":\"Malware detected: ${status}. $(echo $files | tr '\n' ' ')\"}"

# Push notification to end-user prompting reboot.
username=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
if [ "$username" != "" ]; then
/Library/Addigy/macmanage/MacManage.app/Contents/MacOS/MacManage action=notify title="Malware Gevonden" description="We hebben Malware gevonden, herstart om te verwijderen!" closeLabel="Niet nu" acceptLabel="Herstart" && sudo -u $username osascript -e 'tell app "loginwindow" to Â«event aevtrrstÂ»'
exit 1
else
reboot
exit 1
fi
else
echo "No Malware found on the system."
fi
fi
fi

# MBBR finished