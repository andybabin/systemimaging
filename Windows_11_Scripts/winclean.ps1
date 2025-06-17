#Tastbar to left
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -Force


#full context menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve


#darkmode
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force;

Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force; 


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


#disable firewall
netsh advfirewall set allprofiles state off

#allow VMAT to talk
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f


#remove widgets 
 reg add "HKLM\Software\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f 

 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" /v "LayoutXMLPath" /d %SCRIPTROOT%\taskbar.xml /f

#enable hyperv
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All


#Remove onedrive
%SystemRoot%\System32\OneDriveSetup.exe /uninstalls

# Kill and restart explorer.exe to apply most changes right now
taskkill /f /im explorer.exe
explorer.exe

