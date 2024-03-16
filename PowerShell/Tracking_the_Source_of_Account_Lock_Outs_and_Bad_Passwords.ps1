#An important preparation is that the extended monitoring is set up in the Default Domain Controllers Policy. 

#Prep work for lockouts
#Account lockout Event ID
$LockOutID = 4740

#Find the PDC
(Get-ADDomain).PDCEmulator
$PDCEmulator = (Get-ADDomain).PDCEmulator

#Query event log
Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
    LogName = 'Security'
    ID = $LockOutID
}

#Parse the event
#Assign to a variable
$events = Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
    LogName = 'Security'
    ID = $LockOutID
}

#Examine some properties
$events[0].Message

#Regex?
$events[0].Message -match 'Caller Computer Name:\s+(?<caller>[^\s]+)'
$Matches.caller

#Cool, but not as easy as:
$events[0].Properties
$events[0].Properties[1].Value

#For all events:
ForEach($event in $events){
    [pscustomobject]@{
        UserName = $event.Properties[0].Value
        CallerComputer = $event.Properties[1].Value
        TimeStamp = $event.TimeCreated
    }
}

#And we'll make that a function
Function Get-ADUserLockouts {
    [CmdletBinding(
        DefaultParameterSetName = 'All'
    )]
    Param (
        [Parameter(
            ValueFromPipeline = $true,
            ParameterSetName = 'ByUser'
        )]
        [Microsoft.ActiveDirectory.Management.ADUser]$Identity
    )
    Begin{
        $LockOutID = 4740
        $PDCEmulator = (Get-ADDomain).PDCEmulator
    }
    Process {
        If($PSCmdlet.ParameterSetName -eq 'All'){
            #Query event log
            $events = Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
                LogName = 'Security'
                ID = $LockOutID
            }
        }ElseIf($PSCmdlet.ParameterSetName -eq 'ByUser'){
            $user = Get-ADUser $Identity
            #Query event log
            $events = Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
                LogName = 'Security'
                ID = $LockOutID
            } | Where-Object {$_.Properties[0].Value -eq $user.SamAccountName}
        }
        ForEach($event in $events){
            [pscustomobject]@{
                UserName = $event.Properties[0].Value
                CallerComputer = $event.Properties[1].Value
                TimeStamp = $event.TimeCreated
            }
        }
    }
    End{}
}

#Usage
Get-ADUserLockouts

#Single user
Get-ADUser 'jesse.pinkman' | Get-ADUserLockouts

#Prep work for bad passwords
#Bad password event ID
$badPwId = 4625

#Get the events from the PDC
$events = Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
    LogName = 'Security'
    ID = $badPwId
}

#Correlate the logon types
$LogonType = @{
    '2' = 'Interactive'
    '3' = 'Network'
    '4' = 'Batch'
    '5' = 'Service'
    '7' = 'Unlock'
    '8' = 'Networkcleartext'
    '9' = 'NewCredentials'
    '10' = 'RemoteInteractive'
    '11' = 'CachedInteractive'
}

#Format the properties
ForEach($event in $events){
    [pscustomobject]@{
        TargetAccount = $event.properties.Value[5]
        LogonType = $LogonType["$($event.properties.Value[10])"]
        CallingComputer = $event.Properties.Value[13]
        IPAddress = $event.Properties.Value[19]
        TimeStamp = $event.TimeCreated
    }
}

#Bring it all together
Function Get-ADUserBadPasswords {
    [CmdletBinding(
        DefaultParameterSetName = 'All'
    )]
    Param (
        [Parameter(
            ValueFromPipeline = $true,
            ParameterSetName = 'ByUser'
        )]
        [Microsoft.ActiveDirectory.Management.ADUser]$Identity
    )
    Begin {
        $badPwId = 4625
        $PDCEmulator = (Get-ADDomain).PDCEmulator
        $LogonType = @{
            '2' = 'Interactive'
            '3' = 'Network'
            '4' = 'Batch'
            '5' = 'Service'
            '7' = 'Unlock'
            '8' = 'Networkcleartext'
            '9' = 'NewCredentials'
            '10' = 'RemoteInteractive'
            '11' = 'CachedInteractive'
        }
    }
    Process {
        If($PSCmdlet.ParameterSetName -eq 'All'){
            #Query event log
            $events = Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
                LogName = 'Security'
                ID = $badPwId
            }
        }ElseIf($PSCmdlet.ParameterSetName -eq 'ByUser'){
            $user = Get-ADUser $Identity
            #Query event log
            $events = Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
                LogName = 'Security'
                ID = $badPwId
            } | Where-Object {$_.Properties[5].Value -eq $user.SamAccountName}
        }
        ForEach($event in $events){
            [pscustomobject]@{
                TargetAccount = $event.properties.Value[5]
                LogonType = $LogonType["$($event.properties.Value[10])"]
                CallingComputer = $event.Properties.Value[13]
                IPAddress = $event.Properties.Value[19]
                TimeStamp = $event.TimeCreated
            }
        }
    }
    End{}
}

#Usage
Get-ADUserBadPasswords | Format-Table

#Single account
Get-ADUser administrator | Get-ADUserBadPasswords | Format-Table