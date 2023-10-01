# Operating System Configuration Changes!

## We start with a list of MITRE techniques:

**Event Triggered Execution: Accessibility Features**  
https://attack.mitre.org/techniques/T1546/008/

**Event Triggered Execution: Windows Management Instrumentation Event Subscription**  
https://attack.mitre.org/techniques/T1546/003/

**Input Capture: Credential API Hooking**  
https://attack.mitre.org/techniques/T1056/004/

**Process Injection**  
https://attack.mitre.org/techniques/T1055/

**Command and Scripting Interpreter**  
https://attack.mitre.org/techniques/T1059/

**Impair Defenses: Disable or Modify Tools**  
https://attack.mitre.org/techniques/T1562/001/

**Hide Artifacts: NTFS File Attributes**  
https://attack.mitre.org/techniques/T1564/004/

**Indicator Removal: File Deletion**  
https://attack.mitre.org/techniques/T1070/004/

**Subvert Trust Controls: Code Signing**  
https://attack.mitre.org/techniques/T1553/002/

**System Binary Proxy Execution**  
https://attack.mitre.org/techniques/T1218/

**Data Staged**  
https://attack.mitre.org/techniques/T1074/

## The Windows Event ID's for the MITRE techniques!

**Event Triggered Execution: Accessibility Features (T1546/008)**  
Adversaries may establish persistence and/or elevate privileges by executing malicious content triggered by accessibility features. Windows Event ID: Not specified

**Event Triggered Execution: Windows Management Instrumentation Event Subscription (T1546/003)**  
Adversaries may establish persistence and elevate privileges by executing malicious content triggered by a Windows Management Instrumentation (WMI) event subscription. Windows Event ID: 19, 20, 21

**Input Capture: Credential API Hooking (T1056/004)**  
Adversaries may use Credential API Hooking to steal credentials and other sensitive data. Windows Event ID: Not specified

**Process Injection (T1055)**  
Adversaries may inject code into processes in order to evade process-based defenses as well as possibly elevate privileges. Windows Event ID: 86

**Command and Scripting Interpreter (T1059)**  
This technique involves running commands or scripts through a command or script interpreter such as cmd.exe, powershell.exe, or bash. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4103** (Windows PowerShell log), **4104** (Windows PowerShell log), and **8004** (Script ran by AMSI).

**Impair Defenses: Disable or Modify Tools (T1562/001)**  
Adversaries may disable security tools to avoid detection of their malware/tools and activities. Windows Event ID: Not specified

**Hide Artifacts: NTFS File Attributes (T1564/004)**  
This technique involves exploiting NTFS file attributes such as Alternate Data Streams or Hidden Attributes to hide files or information. Possible Windows Event IDs associated with this technique are **4656** (A handle to an object was requested), **4660** (An object was deleted), **4663** (An attempt was made to access an object), and **4690** (An attempt was made to duplicate a handle to an object).

**Indicator Removal: File Deletion (T1070/004):**  
 This technique involves deleting files that could provide indicators of an attacker's presence or activity. Possible Windows Event IDs associated with this technique are **4660** (An object was deleted), **4663** (An attempt was made to access an object), **5140** (A network share object was accessed), **5145** (A network share object was checked to see whether client can be granted desired access), and **5156** (The Windows Filtering Platform has permitted a connection).

**Subvert Trust Controls: Code Signing (T1553/002)**  
Adversaries may abuse code signing to subvert trust controls in order to validate malicious software as being produced by a legitimate software vendor. Windows Event ID: Not specified

**System Binary Proxy Execution (T1218/011)**  
Adversaries may execute their own malicious payloads by hijacking the binaries or commands of a system binary. Windows Event ID: Not specified

**Data Staged (T1074)**  
This technique involves storing collected data in a temporary or hidden location on the system or network in preparation for later access or exfiltration. Possible Windows Event IDs associated with this technique are **4656** (A handle to an object was requested), **4660** (An object was deleted), **4663** (An attempt was made to access an object), and **5140** (A network share object was accessed).

## Links to the Microsoft documentation for some Windows Event ID's:

https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4660

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4663

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4688

https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-592

https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4103

https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4697

https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4656

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4690

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4699

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4702

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5038

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5140

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5145

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5156

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-6281

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logging_windows

https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon

## If you have included your client systems in Microsoft Defender for Endpoint, you can research threats with advanced hunting.

**Example queries 1:**  
Hunt for registry creation in Image File Execution Options (IFEO) accessibility features:  
```
DeviceRegistryEvents
| where RegistryKey contains "Image File Execution Options"
| where ActionType == "RegistryKeyCreated"
```

<img src="/Different_hunting_methods/Images/Hunt_Query_2.png" alt="Hunting Query">

**Example queries 2:**  
Hunt for process injection with mavinject.exe:  
```
DeviceEvents
| where ActionType == "CreateRemoteThreadApiCall"
| where InitiatingProcessFileName =~ "mavinject.exe"
| where InitiatingProcessCommandLine contains "/INJECTRUNNING"
| extend targetProcess = (parsejson(AdditionalFields).TargetProcess).CommandLine
| project DeviceName , ActionType , InitiatingProcessFileName, InitiatingProcessCommandLine, targetProcess
```

**Example queries 3:**  
Hunt for schedule task creation:  
```
DeviceProcessEvents
| where FileName == "schtasks.exe"
| where ActionType == "ProcessCreated"
```

<img src="/Different_hunting_methods/Images/Hunt_Query_3.png" alt="Hunting Query">

**Example queries 4:**  
Hunt for exclusion addition to MDE policy:  
```
DeviceProcessEvents
| where FileName == "powershell.exe"
| where ActionType == "ProcessCreated"
| where ProcessCommandLine contains "-ExecutionPolicy Bypass"
| where ProcessCommandLine contains "Defender"
```

<img src="/Different_hunting_methods/Images/Hunt_Query_4.png" alt="Hunting Query">

## Azure Arc: Monitor file and registry integrity!

**You can integrate your on-premises server systems with Azure Arc to monitor the systems specifically.**  

<img src="/Different_hunting_methods/Images/Azure_Arc.png.png" alt="Azure Arc">