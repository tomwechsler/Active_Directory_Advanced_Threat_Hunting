# Local host infection and malicious behavior!

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

**If there is any suspicion or concrete compression on a unit, you can isolate it immediately!**  

<img src="/Different_hunting_methods/Images/Example_1.png" alt="Device Isolation">
