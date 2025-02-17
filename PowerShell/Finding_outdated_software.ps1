###############################################
#Finding Missing Patches and Outdated Software
###############################################

#We search for all updates that are not hidden and not installed
(New-Object -ComObject Microsoft.Update.Session).CreateupdateSearcher().Search("IsHidden=0 and IsInstalled=0").Updates | Select-Object Title

#Search in the registry for the installed software
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object Displayname,Publisher,Version,Installdate

#Search in the registry for the installed software
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object Displayname,Publisher,Version,Installdate