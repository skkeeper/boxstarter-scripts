# http://boxstarter.org/package/url?

$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

Set-TaskbarSmall
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

#region WindowsExtras
  cinst -y TelnetClient -source windowsFeatures
  cinst -y IIS-HttpCompressionDynamic -source windowsfeatures
#endregion

#region DotNetAndPowershell
  cinstm -y PowerShell
  cinstm -y DotNet4.0
  cinstm -y DotNet4.5
  cinstm -y mono
#endregion

#region Runtimes
  cinst -y flashplayerplugin
  cinst -y java.jdk
  cinst -y nodejs.install
  cinst -y python
  cinst -y scriptcs
#endregion

#region essentials
  cinst -y vlc
  cinst -y 7zip.install
  cinst -y sysinternals
  cinst -y irfanview
  cinst -y sumatrapdf
  cinst -y mpc-hc
  cinst -y ccleaner
  cinst -y defraggler
  cinst -y treesizefree #this was outdated
  cinst -y classic-shell
#endregion

#region Browsers
  cinst -y google-chrome-x64
  cinst -y firefox -installArgs l=en-GB
#endregion

#region devTools
  cinst -y cmder
  cinst -y notepadplusplus.install
  cinst -y notepad2
  cinst -y SublimeText3
  cinst -y sublimetext3-contextmenu
  cinst -y pycharm-community
  cinst -y androidstudio
  cinst -y winmerge
#endregion

#region games
  cinst -y steam
#endregion

#region goingIntoTheExtras
  cinst -y hexchat
  cinst -y libreoffice
  cinst -y foxitreader
  cinst -y Paint.net
#endregion

Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }
