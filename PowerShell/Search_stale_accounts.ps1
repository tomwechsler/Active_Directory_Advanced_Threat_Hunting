#Let me explain my "stale"
#1. Haven't logged in for X days
#2. Hasn't logged in
#3. Created at least X days ago

#The KRBTGT account will be listed, but is not to be considered here.

#Using Search-ADAccount
Search-ADAccount -AccountInactive -TimeSpan '90.00:00:00' -UsersOnly

#Using a filter
Get-ADUser "Leonard.Clark" -Properties LastLogonTimeStamp | Select-Object Name,LastLogonTimeStamp

#If it is older than $LogonDate
$LogonDate = (Get-Date).AddHours(-1).ToFileTime()
Get-ADUser -Filter {LastLogonTimeStamp -lt $LogonDate}

#If it doesn't have value
Get-ADUser -Filter {LastLogonTimeStamp -notlike "*"} -Properties LastLogonTimeStamp |
Select-Object Name,LastLogonTimeStamp

#And if the account was created before $createdDate
$createdDate = (Get-Date).AddDays(-14)
Get-ADUser -Filter {Created -lt $createdDate} -Properties Created |
Select-Object Name,Created

#Add them all together:
$filter = {
    ((LastLogonTimeStamp -lt $logonDate) -or (LastLogonTimeStamp -notlike "*"))
    -and (Created -lt $createdDate)
}

Get-ADuser -Filter $filter | Select-Object SamAccountName

#Functionize it
Function Get-ADStaleUsers {
    [cmdletbinding()]
    Param (
        [datetime]$NoLogonSince = (Get-Date).AddDays(-90),
        [datetime]$CreatedBefore = (Get-Date).AddDays(-14)
    )
    $NoLogonString = $NoLogonSince.ToFileTime()
    $filter = {
        ((LastLogonTimeStamp -lt $NoLogonString) -or (LastLogonTimeStamp -notlike "*"))
        -and (Created -lt $createdBefore)
    }
    Write-Host $filter
    Get-ADuser -Filter $filter
}

#Usage
Get-ADStaleUsers

#Usage
Get-ADStaleUsers -NoLogonSince (Get-Date).AddDays(-30) -CreatedBefore (Get-Date).AddDays(-1)