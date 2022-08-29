# W10 21H1
# Take Cortana off the taskbar
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowCortanaButton /t REG_DWORD /d 0 /f
# Hide People button
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People /v PeopleBand /t REG_DWORD /d 0 /f
# Delete Windows Defender tray from startup
reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v SecurityHealth /f
# Disable Skype from startup
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\Microsoft.SkypeApp_kzf8qxf38zg5c\SkypeStartup" /v State /t REG_DWORD /d 0 /f
# Do not hide tray items when they get cluttered
#reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer /v EnableAutoTray /t REG_DWORD /d 0 /f


#remove news and crap
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f






# W11 21H2 + W10 21H1

# Disable xbox game DVR capture
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR /v AppCaptureEnabled /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR /v HistoricalCaptureEnabled /t REG_DWORD /d 0 /f
# Show file extensions
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
# Opening explorer opens in THIS PC rather than RECENT FILES
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v LaunchTo /t REG_DWORD /d 1 /f
# Take Search off the taskbar
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
# Hide Task View button
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowTaskViewButton /t REG_DWORD /d 0 /f
# Show hidden files
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 1 /f
# Show hidden system files
#reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowSuperHidden /t REG_DWORD /d 1 /f
# Disable lock screen window when using password, saving one extra click
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /v NoLockScreen /t REG_DWORD /d 1 /f
# Enable Dark Mode for apps
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
# Enable Dark Mode for system
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
# Disable UAC prompts
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
# Delete OneDrive from startup
#reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v OneDrive /f
# Delete all taskbar shorcuts to get rid of Edge, Store and more
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /v Favorites /f
# Disable hibernation to get rid of hiberfile.sys
powercfg.exe -h off


#clear image from wallpaper
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallPaper /t REG_SZ /d " " /f

#make wallpaper Black as RGB 
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v Background /t REG_SZ /d "0 0 0" /f


#change sound settings to none
New-ItemProperty -Path HKCU:\AppEvents\Schemes -Name "(Default)" -Value ".None" -Force | Out-Null
Get-ChildItem -Path "HKCU:\AppEvents\Schemes\Apps" | Get-ChildItem | Get-ChildItem | Where-Object {$_.PSChildName -eq ".Current"} | Set-ItemProperty -Name "(Default)" -Value ""


#Get Current Setting before change
Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" | select ShellFeedsTaskbarViewMode
 
#Remove News and Interest Using Powershell
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2
 
#Get Current Setting after change
Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" | select ShellFeedsTaskbarViewMode


#disable hibernation
powercfg -h off

#make sleep 1 hour on battery
powercfg.exe -change standby-timeout-dc 60

#never sleep on AC power
powercfg.exe -change standby-timeout-ac 0

#monitor sleep 30 min on battery
powercfg.exe -change monitor-timeout-dc 30

#monitor never sleep on AC
powercfg.exe -change monitor-timeout-ac 0

#disable lock screen on battery
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 0

#allow WMI through the firewall
netsh advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable=yes

#allow VMAT to talk
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

# Kill and restart explorer.exe to apply most changes right now
taskkill /f /im explorer.exe
explorer.exe
