# A more conservative version of "windows10_devmachine.ps1"

# Commandline: START http://boxstarter.org/package/nr/url?
# Internet Explorer: http://boxstarter.org/package/url?

# The following settings will ask you for your windows password and then
# successfuly reboot the machine everytime it needs to. After Boxstarter is
# done autologin won't be enabled.
$Boxstarter.RebootOk=$true    # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true   # Save my password securely and auto-login after a reboot

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

Set-TaskbarOptions -Size Small -Lock -Dock Top
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst

# Install Windows Update and reboot
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

#region WindowsExtras
  cinst -y TelnetClient -source windowsFeatures
#endregion

#region Runtimes
  cinst -y java.jdk
  cinst -y nodejs.install
#endregion

#region essentials
  cinst -y 7zip.install
  cinst -y vlc
  cinst -y irfanview
  cinst -y irfanviewplugins
  cinst -y sumatrapdf
  cinst -y everything
  cinst -y notepadplusplus.install
  cinst -y notepad2
  cinst -y hashcheck
#endregion

#region productivity
  cinst -y libreoffice
  cinst -y Paint.net
#endregion

# Make sure some windows update didn't creep on us after installing all
# those apps
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }
