# RUN COMMANDS BELLOW IN POWERSHELL
# . { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
# Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/skkeeper/boxstarter-scripts/master/windows10_devmachine.ps1 -DisableReboots

# The following settings will ask you for your windows password and then
# successfuly reboot the machine everytime it needs to. After Boxstarter is
# done autologin won't be enabled.
$Boxstarter.RebootOk=$true    # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true   # Save my password securely and auto-login after a reboot

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

# Power Options - disable hibernation and disable monitor standby
Write-Host "Configuring power options..."
powercfg -change -monitor-timeout-ac 0
powercfg -change -standby-timeout-ac 0
powercfg -h off

Set-TaskbarOptions -Size Small -Lock -Dock Top
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst

# Disables the Bing Internet Search when searching from the search field in the Taskbar or Start Menu.
Disable-BingSearch

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
#endregion

#region Runtimes
  cinst -y flashplayerplugin
  cinst -y openjdk
  cinst -y nodejs
  cinst -y python
#endregion

#region essentials
  cinst -y 7zip
  cinst -y vlc
  cinst -y mpc-hc
  cinst -y sysinternals
  cinst -y irfanview
  cinst -y irfanviewplugins
  cinst -y sumatrapdf
  cinst -y defraggler
  cinst -y treesizefree
  cinst -y everything
  cinst -y hashcheck
  cinst -y foobar2000
  cinst -y mediainfo
  cinst -y mediainfo-cli
  cinst -y mediatab
  cinst -y rsync # the ssh command that comes with this is kinda broken, alias ssh=your old ssh binary (cmder for example)
  cinst -y putty
  cinst -y kitty
#endregion

#region Browsers
  cinst -y google-chrome
  cinst -y firefox --params "l=en-GB"
#endregion

#region devTools
  #cinst -y cmder
  cinst -y notepadplusplus
  cinst -y notepad2-mod
  cinst -y neovim
  cinst -y alacritty
  cinst -y ripgrep
  cinst -y ag
  cinst -y fd
  cinst -y universal-ctags
  cinst -y winmerge
  cinst -y meld
  cinst -y hxd
  cinst -y dbeaver
  cinst -y spring-boot-cli --ignoredependencies # spring-boot-cli depends on jdk, but it might not match the one we installed earlier in this script, so we ignore it
  cinst -y maven
  cinst -y Bat
#endregion

#region goingIntoTheExtras
  cinst -y chocolateygui
  cinst -y powertoys
  #cinst -y hexchat
  cinst -y libreoffice-fresh
  cinst -y FoxitReader
  cinst -y paint.net
  #cinst -y sharex
  cinst -y unchecky
  cinst -y ffmpeg
  cinst -y youtube-dl
  cinst -y Wget
  cinst -y icaros
  #cinst -y patheditor
  cinst -y winscp
  cinst -y quicklook
#endregion

#region nirsoft
  cinst -y csvfileview
  cinst -y bluescreenview
  cinst -y hashmyfiles
#endregion

# Make sure some windows update didn't creep on us after installing all
# those apps
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

# Taskbar items
Install-ChocolateyPinnedTaskBarItem "$env:localappdata\Google\Chrome\Application\chrome.exe"
