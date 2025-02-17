##################################
#Finding Misconfigured Permissions
##################################

whoami

net user tom /domain

#We search recursively for all files with the extensions .exe and .ps1
Get-ChildItem C:\ -Force -Recurse -Include *.exe,*.ps1

#Suppressed errors
Get-ChildItem C:\ -Force -Recurse -Include *.exe,*.ps1 -ErrorAction SilentlyContinue

#We get the ACL of all files with the extensions .exe and .ps1
Get-ChildItem C:\ -Force -Recurse -Include *.exe,*.ps1 -ErrorAction SilentlyContinue | Get-Acl

#We search for the string "Users Allow  FullControl" in the ACL of all files with the extensions .exe and .ps1
Get-ChildItem C:\ -Force -Recurse -Include *.exe,*.ps1 -ErrorAction SilentlyContinue | Get-Acl | Out-String -Stream | Select-String -Pattern "Users Allow  FullControl"

#We pretend that we have found this script
Get-ChildItem C:\ -Recurse -Filter "reboot-event.ps1" -ErrorAction SilentlyContinue