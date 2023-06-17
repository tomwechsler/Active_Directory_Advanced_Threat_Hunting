#Account Manipulation
https://attack.mitre.org/techniques/T1098/


#Get-Member
Get-ADUser -Filter * -Properties * | Get-Member -MemberType property

#Resetting passwords
#Current state 
Get-ADUser 'Jonathan.Fisher' -Properties PasswordExpired,LockedOut | Format-Table Name,PasswordExpired,LockedOut

#Reset the password
$securePassword = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
Set-ADAccountPassword 'Jonathan.Fisher' -NewPassword $securePassword -Reset

#Force a password change
Set-ADUser 'Jonathan.Fisher' -ChangePasswordAtLogon $true

#Current state 
Get-ADUser 'Jonathan.Fisher' -Properties PasswordExpired,LockedOut | Format-Table Name,PasswordExpired,LockedOut

#Unlocking accounts
#Current State
Get-ADUser 'Leonard.Clark' -Properties LockedOut | Format-Table Name,LockedOut

#Unlock that account
Unlock-ADAccount 'Leonard.Clark'