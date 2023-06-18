#Some Preparations
Install-Module ImportExcel
Import-Module ImportExcel

#Gather info
#Single User's group membership:
(Get-ADUser 'Leonard.Clark' -Properties MemberOf).MemberOf

#Nicely formated
(Get-ADUser 'Leonard.Clark' -Properties MemberOf).MemberOf | ForEach-Object {Get-ADGroup $_}

#Multiple Users
Get-ADUser -Filter {Title -like '*Engineer*'} -Properties MemberOf

#Format
$users = Get-ADUser -Filter {Title -like '*Engineer*'} -Properties MemberOf
foreach($user in $users){
    [pscustomobject]@{
        Name = $user.Name
        User = $user.SamAccountName
        Memberships = ($user.MemberOf | ForEach-Object{Get-ADGroup $_}).Name
    }
}

#Make it presentable
$userGroups = @()
$users = Get-ADUser -Filter {Title -like '*Engineer*'} -Properties MemberOf
foreach($user in $users){
    $userGroups += [pscustomobject]@{
        User = $user.SamAccountName
        Name = $user.Name
        Memberships = ($user.MemberOf | ForEach-Object{Get-ADGroup $_}).Name -join ', '
    }
}
$userGroups | Export-Excel .\UserGroups.xlsx -Title 'Engineer Group Memberships'

#Validate
Import-Excel .\UserGroups.xlsx -StartRow 2