#Account Manipulation
https://attack.mitre.org/techniques/T1098/

#Getting the password expiration date
#msDS-UserPasswordExpiryTimeComputed property
$userParams = @{
    Identity = 'Leonard.Clark'
    Properties = 'Name','msDS-UserPasswordExpiryTimeComputed'
}
Get-ADUser @userParams | Format-Table $userParams['Properties']

#Save to a variable
$user = Get-ADUser @userParams

#Try Get Date
Get-Date $user.'msDS-UserPasswordExpiryTimeComputed'

#.NET
[datetime]::FromFileTime($user.'msDS-UserPasswordExpiryTimeComputed')
$expirationDate = [datetime]::FromFileTime($user.'msDS-UserPasswordExpiryTimeComputed')

#Now how far away is that?
New-TimeSpan -Start (Get-Date) -End $expirationDate

#Finding all users' with soon expiring passwords
#First we need a filter:
$filter = {Enabled -eq $true -and PasswordNeverExpires -eq $false}

#Get all those users
Get-ADUser -Filter $filter

#Then define what 'soon' is
$days = 7

#Convert that to filetime
$date = (Get-Date).AddDays($days).ToFileTime()

$date

#And get all the users
Get-ADUser -Filter $filter -Properties 'msDS-UserPasswordExpiryTimeComputed' | `
Where-Object {$_.'msDS-UserPasswordExpiryTimeComputed' -lt $date} | Select-Object UserPrincipalName