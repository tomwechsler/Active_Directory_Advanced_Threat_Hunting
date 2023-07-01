# MITRE ATT&CK Techniques and the Windows Eventlog ID's

## Steal or Forge Kerberos Tickets: Kerberoasting 
https://attack.mitre.org/techniques/T1558/003/ 

**4769(S, F): A Kerberos service ticket was requested**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4769
 

## Access Token Manipulation 
https://attack.mitre.org/techniques/T1134/ 

**5136(S): A directory service object was modified**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5136

**4661(S, F): A handle to an object was requested**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4661

**5137(S): A directory service object was created**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5137

**5141(S): A directory service object was deleted**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5141

## OS Credential Dumping: DCSync 
https://attack.mitre.org/techniques/T1003/006/ 

**4932(S): Synchronization of a replica of an Active Directory naming context has begun**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4932
 

## Access Token Manipulation: SID-History Injection 
https://attack.mitre.org/techniques/T1134/005/ 

**Security assessment: Unsecure SID History attributes**  
https://learn.microsoft.com/en-us/defender-for-identity/security-assessment-unsecure-sid-history-attribute

**4765(S): SID History was added to an account**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4765 

## Indicator Removal: Clear Windows Event Logs 
https://attack.mitre.org/techniques/T1070/001/

## Brute Force  
https://attack.mitre.org/techniques/T1110/

**4740(S): A user account was locked out**  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4740
