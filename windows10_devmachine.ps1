# Commandline: START http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/skkeeper/boxstarter-scripts/master/windows10_devmachine.ps1
# Internet Explorer: http://boxstarter.org/package/url?https://raw.githubusercontent.com/skkeeper/boxstarter-scripts/master/windows10_devmachine.ps1

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

#region DotNetAndPowershell
  cinst -y PowerShell
  cinst -y DotNet4.0
  cinst -y DotNet4.5
  cinst -y mono
#endregion

#region Runtimes
  cinst -y flashplayerplugin
  cinst -y jdk
  cinst -y nodejs.install
  # TODO: Investigate way of installing python 2 and 3 at the same time
  cinst -y python
  cinst -y scriptcs
#endregion

#region essentials
  cinst -y vlc
  cinst -y 7zip.install
  cinst -y sysinternals
  cinst -y irfanview
  cinst -y irfanviewplugins
  cinst -y sumatrapdf
  cinst -y mpc-hc
  # cinst -y ccleaner
  cinst -y defraggler
  cinst -y treesizefree
  cinst -y classic-shell
  cinst -y everything
  cinst -y hashcheck
  cinst -y foobar2000
  cinst -y mediainfo
  cinst -y mediainfo-cli
  cinst -y mediatab
#endregion

#region Browsers
  cinst -y google-chrome-x64
  #cinst -y firefox -installArgs l=en-GB
#endregion

#region devTools
  #cinst -y cmder
  cinst -y notepadplusplus.install
  cinst -y notepad2-mod
  #cinst -y SublimeText3
  #cinst -y sublimetext3-contextmenu
  #cinst -y pycharm-community
  #cinst -y androidstudio
  cinst -y winmerge
  #cinst -y smartgit
  cinst -y hxd
#endregion

#region goingIntoTheExtras
  #cinst -y hexchat
  cinst -y libreoffice
  #cinst -y foxitreader
  cinst -y Paint.net
  #cinst -y sharex
  cinst -y unchecky
  cinst -y ffmpeg
  cinst -y youtube-dl
  #cinst -y icaros
  cinst -y zeal.install
  cinst -y patheditor
#endregion

# Make sure some windows update didn't creep on us after installing all
# those apps
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

# Taskbar items
Install-ChocolateyPinnedTaskBarItem "$env:localappdata\Google\Chrome\Application\chrome.exe"
