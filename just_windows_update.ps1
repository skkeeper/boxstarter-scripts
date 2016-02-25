# Commandline: START http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/skkeeper/boxstarter-scripts/master/just_windows_update.ps1
# Internet Explorer: http://boxstarter.org/package/url?https://raw.githubusercontent.com/skkeeper/boxstarter-scripts/master/just_windows_update.ps1

# The following settings will ask you for your windows password and then
# successfuly reboot the machine everytime it needs to. After Boxstarter is
# done autologin won't be enabled.
$Boxstarter.RebootOk=$true    # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true   # Save my password securely and auto-login after a reboot

# Install Windows Update and reboot
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }
