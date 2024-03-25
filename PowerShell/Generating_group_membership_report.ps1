#Gather info about a single User's group membership:
(Get-ADUser 'Max.Pane' -Properties MemberOf).MemberOf

#Nicely formated
(Get-ADUser 'Max.Pane' -Properties MemberOf).MemberOf | ForEach-Object {Get-ADGroup $_}

#Multiple Users
Get-ADUser -Filter {Title -like '*Manager*'} -Properties MemberOf

#Format
$users = Get-ADUser -Filter {Title -like '*Manager*'} -Properties MemberOf
foreach($user in $users){
    [pscustomobject]@{
        Name = $user.Name
        User = $user.SamAccountName
        Memberships = ($user.MemberOf | ForEach-Object{Get-ADGroup $_}).Name
    }
}

#Install the Excel module
Install-Module ImportExcel -Scope CurrentUser -Force -AllowClobber

#Import the module
Import-Module ImportExcel 

#Make it presentable
$userGroups = @()
$users = Get-ADUser -Filter {Title -like '*Manager*'} -Properties MemberOf
foreach($user in $users){
    $userGroups += [pscustomobject]@{
        User = $user.SamAccountName
        Name = $user.Name
        Memberships = ($user.MemberOf | ForEach-Object{Get-ADGroup $_}).Name -join ', '
    }
}
$userGroups | Export-Excel .\UserGroups.xlsx -Title 'Manager Group Memberships'

#Validate
Import-Excel .\UserGroups.xlsx -StartRow 2

#Functionize it!
Function Get-ADUserGroupMembershipReport {
    [CmdletBinding()]
    Param(
        [Parameter(
            ValueFromPipeline = $true
        )]
        [Microsoft.ActiveDirectory.Management.ADUser]$Identity,
        [Parameter(
            Mandatory = $true
        )]
        [string]$FilePath,
        [string]$Title = 'AD User Membership Report',
        [string[]]$Properties
    )
    begin{
        $out = @()
    }
    process{
        $propertiesToQuery = $Properties + 'MemberOf'
        $user = Get-ADUser $Identity -Properties $propertiesToQuery
        $tmp = [pscustomobject]@{
            User = $user.SamAccountName
            Name = $user.Name
            Memberships = ($user.MemberOf | ForEach-Object{Get-ADGroup $_}).Name -join ', '
        }
        ForEach($property in $Properties){
            $tmp | Add-Member -MemberType NoteProperty -Name $property -Value $user."$property"
        }
        $out += $tmp
    }
    end{
        $out | Export-Excel $FilePath -Title $Title
    }
}

#Usage
Get-ADUserGroupMembershipReport -Identity 'Max.Pane' -FilePath .\Test.xlsx -Title "Max's Memberships"

#Verify
Import-Excel .\Test.xlsx -StartRow 2
Remove-Item .\Test.xlsx

#All of a manager's reports
Get-ADUser -Filter {Manager -eq 'Max.Pane'} | `
Get-ADUserGroupMembershipReport -FilePath .\Test.xlsx -Properties Title -Title "Minion membership report for Max Pane"