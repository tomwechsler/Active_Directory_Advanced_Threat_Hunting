# Local host infection and malicious behavior!

## We start with a list of MITRE techniques:

**Indicator Removal: File Deletion**  
https://attack.mitre.org/techniques/T1070/004/

**Obfuscated Files or Information**  
https://attack.mitre.org/techniques/T1027/

**Deobfuscate/Decode Files or Information**  
https://attack.mitre.org/techniques/T1140/

**System Binary Proxy Execution: Rundll32**  
https://attack.mitre.org/techniques/T1218/011/

**Hijack Execution Flow: DLL Search Order Hijacking**  
https://attack.mitre.org/techniques/T1574/001/

**Command and Scripting Interpreter**  
https://attack.mitre.org/techniques/T1059/

**Indicator Removal**  
https://attack.mitre.org/techniques/T1070/

**Hide Artifacts: NTFS File Attributes**  
https://attack.mitre.org/techniques/T1564/004/

**Subvert Trust Controls: Code Signing**  
https://attack.mitre.org/techniques/T1553/002/

**Archive Collected Data**  
https://attack.mitre.org/techniques/T1560/

**Scheduled Task/Job**  
https://attack.mitre.org/techniques/T1053/

**Command and Scripting Interpreter: PowerShell**  
https://attack.mitre.org/techniques/T1059/001/

**System Services: Service Execution**  
https://attack.mitre.org/techniques/T1569/002/

**Native API**  
https://attack.mitre.org/techniques/T1106/

**Event Triggered Execution: Accessibility Features**  
https://attack.mitre.org/techniques/T1546/008/

**Boot or Logon Autostart Execution: Shortcut Modification**  
https://attack.mitre.org/techniques/T1547/009/

**Create or Modify System Process: Windows Service**  
https://attack.mitre.org/techniques/T1543/003/

**Hijack Execution Flow: Path Interception by PATH Environment Variable**  
https://attack.mitre.org/techniques/T1574/007/

**Create or Modify System Process: Windows Service**  
https://attack.mitre.org/techniques/T1543/003/

**Event Triggered Execution: Windows Management Instrumentation Event Subscription**  
https://attack.mitre.org/techniques/T1546/003/

**Data Staged**  
https://attack.mitre.org/techniques/T1074/

# The Windows Event ID's for the MITRE techniques!

**Indicator Removal: File Deletion (T1070/004):**  
 This technique involves deleting files that could provide indicators of an attacker's presence or activity. Possible Windows Event IDs associated with this technique are **4660** (An object was deleted), **4663** (An attempt was made to access an object), **5140** (A network share object was accessed), **5145** (A network share object was checked to see whether client can be granted desired access), and **5156** (The Windows Filtering Platform has permitted a connection).

**Obfuscated Files or Information (T1027):**  
This technique involves obfuscating files or information to make them more difficult to detect or analyze. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4103** (Windows PowerShell log), **4104** (Windows PowerShell log), and **400** (Windows Defender Application Control blocked an operation).

**Deobfuscate/Decode Files or Information (T1140)**.  
This technique involves decrypting or deobfuscating files or information that were previously encrypted or obfuscated. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4103** (Windows PowerShell log), **4104** (Windows PowerShell log), and **4656** (A handle to an object was requested).

**System Binary Proxy Execution Rundll32 (T1218/011)**  
This technique involves the execution of malicious code via the system binary rundll32.exe, which is used to load and execute functions from DLL files. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4656** (A handle to an object was requested), **4658** (The handle to an object was closed) and **4697** (A service was installed in the system).

**Hijack Execution Flow: DLL Search Order Hijacking (T1574/001)**  
This technique involves placing a malicious DLL file in a directory that is searched before the legitimate DLL file's directory to hijack the execution flow. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4656** (A handle to an object was requested), **4658** (The handle to an object was closed), and **4697** (A service was installed in the system).

**Command and Scripting Interpreter (T1059)**  
This technique involves running commands or scripts through a command or script interpreter such as cmd.exe, powershell.exe, or bash. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4103** (Windows PowerShell log), **4104** (Windows PowerShell log), and **8004** (Script ran by AMSI).

**Indicator Removal on Host: Clear Command History (T1070/003)**  
This technique involves clearing the command history from a command line session to remove traces of an attacker's activities. Possible Windows Event IDs associated with this technique are none because this action is not logged.

**Hide Artifacts: NTFS File Attributes (T1564/004)**  
This technique involves exploiting NTFS file attributes such as Alternate Data Streams or Hidden Attributes to hide files or information. Possible Windows Event IDs associated with this technique are **4656** (A handle to an object was requested), **4660** (An object was deleted), **4663** (An attempt was made to access an object), and **4690** (An attempt was made to duplicate a handle to an object).

**Subvert Trust Controls: Code Signing (T1553/002)**  
This technique involves subverting trust controls by signing malicious code with stolen or forged certificates to feign code authenticity and integrity. Possible Windows Event IDs associated with this technique are **4656** (A handle to an object was requested), **4658** (The handle to an object was closed), **4697** (A service was installed in the system), **5038** (Code integrity determined that the image hash of a file is not valid) and **6281** (Code integrity determined that the page hashes of an image file are not valid).

**Archive Collected Data (T1560)**  
This technique involves archiving collected data in a compressed or encrypted file or container to facilitate transfer or storage. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4656** (A handle to an object was requested), **4660** (An object was deleted), and **4663** (An attempt was made to access an object).

**Scheduled Task/Job (T1053)**  
This technique involves creating or modifying scheduled tasks or jobs to execute malicious code at specific times or events. Possible Windows Event IDs associated with this technique are **106** (Scheduled task registered), **140** (Scheduled task updated), **141** (Scheduled task deleted), **4698** (A scheduled task was created), **4699** (A scheduled task was deleted), and **4702** (A scheduled task was updated).

**Command and Scripting Interpreter**  
PowerShell (T1059/001): This technique involves running commands or scripts through the PowerShell interpreter. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4103** (Windows PowerShell log), **4104** (Windows PowerShell log), and **8004** (Script ran by AMSI).

**System Services: Service Execution (T1569/002)**  
This technique involves executing malicious code as a system service or via a system service. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4697** (A service was installed in the system), **7045** (A service was installed in the system), and **7036** (The service entered the running state).

**Native API (T1106)**  
This technique involves executing malicious code via native API functions such as CreateProcess or CreateThread that are not logged by higher levels of the Windows API. Possible Windows Event IDs associated with this technique are none, as this action is not logged.

**Event Triggered Execution: Accessibility Features (T1546/008)**  
This technique involves exploiting accessibility features such as sticky keys or Ease of Access Center to execute malicious code at logon. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4624** (An account was successfully logged on) and **4648** (A logon was attempted using explicit credentials).

**Boot or Logon Autostart Execution: Shortcut Modification (T1547/009)**  
This technique involves modifying shortcuts executed at logon or system startup to execute malicious code. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4624** (An account was successfully logged on), and **4648** (A logon was attempted using explicit credentials).

**Create or Modify System Process: Windows Service (T1543/003)**  
This technique involves creating or modifying a Windows service to execute or persist malicious code. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created), **4697** (A service was installed in the system), **7045** (A service was installed in the system), and **7036** (The service entered the running state).

**Hijack Execution Flow: Path Interception by PATH Environment Variable (T1574/007)**  
This technique involves manipulating the PATH environment variable to execute a malicious executable instead of a legitimate one. Possible Windows Event IDs associated with this technique are **592** (A new process has been created), **4688** (A new process has been created) and **4656** (A handle to an object was requested).

**Event Triggered Execution: Windows Management Instrumentation Event Subscription (T1546/003)**  
This technique involves creating or modifying a WMI event subscription to execute malicious code on a specific event. Possible Windows Event IDs associated with this technique are **19** (WMIEventFilter activity detected), **20** (WMIEventConsumer activity detected), **21** (WMIEventConsumerToFilter activity detected), and **5861** (WMI Event Subscription).

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

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5038

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5140

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5145

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-5156

https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-6281

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logging_windows

## If you have included your client systems in Microsoft Defender for Endpoint, you can research threats with advanced hunting.

**Example queries 1:**  
Hunt for schedule task creation:  
```
DeviceProcessEvents  
| where FileName == "schtasks.exe"  
| where ActionType == "ProcessCreated"  
| where ProcessCommandLine contains "create"  
| project DeviceName, AccountName, InitiatingProcessParentFileName, InitiatingProcessFileName, InitiatingProcessCommandLine, FileName, ProcessCommandLine
```

<img src="/Different_hunting_methods/Images/Hunt_Query_1.png" alt="Hunting Query">

**Example queries 2:**  
Hunt for network configuration discovery:  
```
DeviceProcessEvents  
| where InitiatingProcessCommandLine contains "Get-WmiObject Win32_NetworkAdapterConfiguration"
```

**Example queries 3:**  
Hunt for execution of a DLL with rundll32.exe using CMD:  
```
DeviceProcessEvents  
| where FileName == "cmd.exe"  
| where ProcessCommandLine contains "rundll32"
```