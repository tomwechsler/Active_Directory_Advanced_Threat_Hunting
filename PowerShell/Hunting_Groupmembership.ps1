#Import Active Directory module
Import-Module ActiveDirectory

#Retrieve all users in AD
$users = Get-ADUser -Filter *

#Go through all users
foreach ($user in $users) {
    #Retrieve the properties
    $username = $user.SamAccountName

    #Get the group memberships
    $groups = Get-ADUser $user.SamAccountName | Get-ADPrincipalGroupMembership | Select-Object -ExpandProperty Name

    #Format and output the information
    Write-Host "Username: $username"
    Write-Host "`tGroupMembership:"

    foreach ($group in $groups) {
        Write-Host "`t`t$group"
    }
}