loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
# Create temporary admin user
dscl . -create /Users/securetoken
dscl . -create /Users/securetoken UserShell /bin/bash
dscl . -create /Users/securetoken RealName "Secure Token"
dscl . -create /Users/securetoken UniqueID 1010”
dscl . -create /Users/securetoken PrimaryGroupID 1000”
dscl . -passwd /Users/securetoken tokenpassword
dscl . -append /Groups/admin GroupMembership securetoken

SECURE_TOKEN_USER="securetoken"
SECURE_TOKEN_USER_PASS="tokenpassword"
NEW_SECURE_TOKEN_USER="localadmin"
NEW_SECURE_TOKEN_USER_PASS="ebFr4mCc"

# Give local admin user secure token using admin user credentials established as part of Setup Assistant
/usr/sbin/sysadminctl -adminUser "$SECURE_TOKEN_USER" -adminPassword "$SECURE_TOKEN_USER_PASS" -secureTokenOn "$NEW_SECURE_TOKEN_USER" -password "$NEW_SECURE_TOKEN_USER_PASS"
exitresult=$(/bin/echo $?)

if [ "$exitresult" = 0 ]; then
    /bin/echo "Successfully added secure Token to ${NEW_SECURE_TOKEN_USER}!"
    # With token successfully added to local admin, delete temp DEP admin user
    /bin/echo "Deleting temp ${SECURE_TOKEN_USER} DEP admin user ..."
    
    exitcode=0
else
    /bin/echo "Failed to add secure Token to ${NEW_SECURE_TOKEN_USER}."
    exitcode=1
fi

#delete temporary user
dscl . -delete /Groups/admin GroupMembership securetoken
dscl . -delete "/Users/securetoken"

exit $exitcode