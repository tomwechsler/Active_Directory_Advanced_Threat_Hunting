#Indicator Removal: Clear Windows Event Logs
https://attack.mitre.org/techniques/T1070/001/


#Remote Session
Enter-PSSession -ComputerName DC01

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