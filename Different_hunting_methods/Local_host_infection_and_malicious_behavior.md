# Local host infection and malicious behavior!

## Lets have a look at the corresponding MITRE techniques:

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

## If you have included your client systems in Microsoft Defender for Endpoint, you can research threats with advanced hunting.

**Example queries 1:**  
Hunt for schedule task creation:  
DeviceProcessEvents  
| where FileName == "schtasks.exe"  
| where ActionType == "ProcessCreated"  
| where ProcessCommandLine contains "create"  
| project DeviceName, AccountName, InitiatingProcessParentFileName, InitiatingProcessFileName, InitiatingProcessCommandLine, FileName, ProcessCommandLine

<img src="/Different_hunting_methods/Images/Hunt_Query_1.png" alt="Hunting Query">

**Example queries 2:**  
Hunt for network configuration discovery:  
DeviceProcessEvents  
| where InitiatingProcessCommandLine contains "Get-WmiObject Win32_NetworkAdapterConfiguration"

**Example queries 3:**  
Hunt for execution of a DLL with rundll32.exe using CMD:  
DeviceProcessEvents  
| where FileName == "cmd.exe"  
| where ProcessCommandLine contains "rundll32"