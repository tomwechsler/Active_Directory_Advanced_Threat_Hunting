# Credential Theft and Ransomware Infection!

## We start with a list of MITRE techniques (Credential Theft):

**OS Credential Dumping**  
https://attack.mitre.org/techniques/T1003/

**Native API**  
https://attack.mitre.org/techniques/T1106/

**Unsecured Credentials: Credentials in Registry**  
https://attack.mitre.org/techniques/T1552/002/

**Steal or Forge Kerberos Tickets: Kerberoasting**  
https://attack.mitre.org/techniques/T1558/003/

**Indicator Removal: File Deletion**  
https://attack.mitre.org/techniques/T1070/004/

**Query Registry**  
https://attack.mitre.org/techniques/T1012/

**Password Policy Discovery**  
https://attack.mitre.org/techniques/T1201/

## The Windows Event ID's for the MITRE techniques!

**OS Credential Dumping**  

- Event ID: 1003 (LSASS credential dumping)  

https://www.microsoft.com/en-us/security/blog/2022/10/05/detecting-and-preventing-lsass-credential-dumping-attacks/

**Native API**  

- Event ID: 4656 (A handle to an object was requested)  

- Event ID: 4663 (An attempt was made to access an object)  

https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/appendix-l--events-to-monitor  

**Unsecured Credentials: Credentials in Registry**  

- Event ID: 4657 (A registry value was modified)  

https://learn.microsoft.com/en-us/windows/security/identity-protection/credential-guard/configure

**Steal or Forge Kerberos Tickets: Kerberoasting**  

Event ID: 4769 (A Kerberos service ticket was requested)  
Event ID: 4771 (Kerberos pre-authentication failed)  

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4769  

**Indicator Removal: File Deletion**  

- Event ID: 4660 (An object was deleted)  

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4660

**Query Registry**  

- Event ID: 4663 (An attempt was made to access an object)  

- Event ID: 4656 (A handle to an object was requested)  
- Event ID: 4657 (A registry value was modified)  

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/audit-registry

**Password Policy Discovery**  

- Event ID: 4793 (The Password Policy Checking API was called)  

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4793


## The list of MITRE techniques (Ransomware Infection):

**Command and Scripting Interpreter**  
https://attack.mitre.org/techniques/T1059/

**System Network Configuration Discovery**  
https://attack.mitre.org/techniques/T1016/

**System Network Connections Discovery**  
https://attack.mitre.org/techniques/T1049/

**Event Triggered Execution**  
https://attack.mitre.org/techniques/T1546/

**Dynamic Resolution**  
https://attack.mitre.org/techniques/T1568/

## Devices integrated in - Microsoft Defender for Endpoint

**If there is any suspicion or concrete compression on a device, you can isolate it immediately!**  

<img src="/Different_hunting_methods/Images/Example_1.png" alt="Device Isolation">

### Hunt for ransomware infection!

https://learn.microsoft.com/en-us/microsoft-365/security/defender/advanced-hunting-find-ransomware

**Stopping multiple processes using taskkill.exe**  

```
// Find attempts to stop processes using taskkill.exe
DeviceProcessEvents
| where Timestamp > ago(1d)
| where FileName =~ "taskkill.exe" 
| summarize taskKillCount = dcount(ProcessCommandLine), TaskKillList = make_set(ProcessCommandLine) by DeviceId, bin(Timestamp, 2m)
| where taskKillCount > 10
```

**Stopping processes using net stop**  

```
// Find attempts to stop processes using net stop
DeviceProcessEvents
| where Timestamp > ago(1d)
| where FileName =~ "net.exe" and ProcessCommandLine has "stop"
| summarize netStopCount = dcount(ProcessCommandLine), NetStopList = make_set(ProcessCommandLine) by DeviceId, bin(Timestamp, 2m)
| where netStopCount > 10
```

**Deletion of data on multiple drives using cipher.exe**  

```
// Look for cipher.exe deleting data from multiple drives
DeviceProcessEvents
| where Timestamp > ago(1d)
| where FileName =~ "cipher.exe" 
// cipher.exe /w flag used for deleting data 
| where ProcessCommandLine has "/w" 
| summarize CipherCount = dcount(ProcessCommandLine),
CipherList = make_set(ProcessCommandLine) by DeviceId, bin(Timestamp, 1m) 
// cipher.exe accessing multiple drives in a short timeframe 
| where CipherCount > 1
```

**Clearing of forensic evidence from event logs using wevtutil**  

```
// Look for use of wevtutil to clear multiple logs
DeviceProcessEvents
| where Timestamp > ago(1d)
| where ProcessCommandLine has "WEVTUTIL" and ProcessCommandLine has "CL"
| summarize LogClearCount = dcount(ProcessCommandLine), ClearedLogList = make_set(ProcessCommandLine) by DeviceId, bin(Timestamp, 5m)
| where LogClearCount > 10
```

**Turning off services using sc.exe**  

```
// Look for sc.exe disabling services
DeviceProcessEvents
| where Timestamp > ago(1d)
| where ProcessCommandLine has "sc" and ProcessCommandLine has "config" and ProcessCommandLine has "disabled"
| summarize ScDisableCount = dcount(ProcessCommandLine), ScDisableList = make_set(ProcessCommandLine) by DeviceId, bin(Timestamp, 5m)
| where ScDisableCount > 10
```

**Turning off System Restore**  

```
DeviceProcessEvents
//Pivoting for rundll32  
| where InitiatingProcessFileName =~ 'rundll32.exe'   
//Looking for empty command line   
and InitiatingProcessCommandLine !contains " " and InitiatingProcessCommandLine != ""  
//Looking for schtasks.exe as the created process  
and FileName in~ ('schtasks.exe')  
//Disabling system restore   
and ProcessCommandLine has 'Change' and ProcessCommandLine has 'SystemRestore' 
and ProcessCommandLine has 'disable'
```

**Backup deletion**  

```
DeviceProcessEvents
| where FileName =~ "wmic.exe"
| where ProcessCommandLine has "shadowcopy" and ProcessCommandLine has "delete"
| project DeviceId, Timestamp, InitiatingProcessFileName, FileName,
ProcessCommandLine, InitiatingProcessIntegrityLevel, InitiatingProcessParentFileName
```