$AppsList = 
#"Microsoft.3DBuilder",
#"microsoft.windowscommunicationsapps",
#"Microsoft.MicrosoftOfficeHub",
#"Microsoft.SkypeApp",
#"Microsoft.Getstarted",
#"Microsoft.ZuneMusic",
#"Microsoft.MicrosoftSolitaireCollection",
#"Microsoft.ZuneVideo",
#"Microsoft.Office.OneNote",
#"Microsoft.People",
#"Microsoft.XboxApp", 
#"Microsoft.Messaging", 
#"Microsoft.Microsoft3DViewer", 
#"Microsoft.WindowsFeedbackHub", 
#"Microsoft.GetHelp", 
#"Microsoft.OneConnect",
#"Microsoft.MixedReality.Portal", 
#"Microsoft.ZuneVideo",
#"Microsoft.XboxGameOverlay",
#"Microsoft.XboxGamingOverlay",
"Microsoft.WindowsAlarms",
#"Microsoft.YourPhone",
#"Microsoft.WindowsSoundRecorder",
#"Microsoft.WindowsMaps",
#"Microsoft.MicrosoftStickyNotes",
#"Microsoft.BingWeather",
#"Microsoft.ScreenSketch",
#"Disney.37853FC22B2CE"

"Clipchamp.Clipchamp",
"Microsoft.BingNews",
"Microsoft.BingSearch",
"Microsoft.BingWeather",
"Microsoft.GamingApp",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.OutlookForWindows",
"Microsoft.MicrosoftStickyNotes",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxSpeechToTextOverlay",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxIdentityProvider",
"Microsoft.YourPhone",
"Microsoft.Todos",
"Microsoft.XboxGameCallableUI",
"Microsoft.ZuneMusic",
"MSTeams"


ForEach ($App in $AppsList)
{
  $PackageFullName = (Get-AppxPackage $App).PackageFullName
  $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.Displayname -eq $App}).PackageName
  write-host $PackageFullName
  Write-Host $ProPackageFullName
 
  if ($PackageFullName)
  {
    Write-Host “Removing Package: $App”
    remove-AppxPackage -package $PackageFullName
  }
  else
  {
    Write-Host “Unable to find package: $App”
  }
 
  if ($ProPackageFullName)
  {
    Write-Host “Removing Provisioned Package: $ProPackageFullName”
    Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName
  }
  else
  {
    Write-Host “Unable to find provisioned package: $App”
  }
}

#Get-AppxPackage *disney* | Remove-AppxPackage
#Get-AppxPackage *SpotifyMusic* | Remove-AppxPackage
#Get-AppxPackage *Xbox* | Remove-AppxPackage

#Get-ProvisionedAppxPackage -Online | `
#Where-Object { $_.PackageName -match "xbox" } | `
#ForEach-Object { Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $_.PackageName }



#taskkill /f /im OneDrive.exetaskkill /f /im OneDrive.exe
#C:\Users\Administrator\AppData\Local\Microsoft\OneDrive\23.107.0521.0001\OneDriveSetup.exe /uninstall