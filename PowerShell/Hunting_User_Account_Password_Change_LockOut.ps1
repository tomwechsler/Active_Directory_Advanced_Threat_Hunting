#Import Active Directory module
Import-Module ActiveDirectory

#Get all users in AD
$users = Get-ADUser -Filter * -Property PasswordLastSet, LockedOut

#Go through all users
foreach ($user in $users) {
    #Retrieve the properties
    $username = $user.SamAccountName
    $passwordLastSet = $user.PasswordLastSet
    $lockedOut = $user.LockedOut

    #Format and output the information
    Write-Host "Username: $username"
    Write-Host "`tLast password change: $passwordLastSet"

    #Check the lock status
    if ($lockedOut) {
        Write-Host "`tThe account is LOCKED"
    } else {
        Write-Host "`tThe account is NOT locked."
    }
}