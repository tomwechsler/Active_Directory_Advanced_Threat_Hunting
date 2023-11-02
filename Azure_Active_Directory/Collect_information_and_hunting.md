# Collect information in Entra ID with AzureADRecon and hunt with Microsoft Sentinel!

## As always we start with a list of MITRE techniques:

### Initial Access

**Drive-by Compromise**  
https://attack.mitre.org/techniques/T1189/

**Exploit Public-Facing Application**  
https://attack.mitre.org/techniques/T1190/

**External Remote Services**  
https://attack.mitre.org/techniques/T1133/

**Phishing**  
https://attack.mitre.org/techniques/T1566/

**Phishing: Spearphishing Link**  
https://attack.mitre.org/techniques/T1566/002/

**Valid Accounts**  
https://attack.mitre.org/techniques/T1078/

### Execution

**Command and Scripting Interpreter**  
https://attack.mitre.org/techniques/T1059/

### Persistence

**Account Manipulation**  
https://attack.mitre.org/techniques/T1098/

**Create Account**  
https://attack.mitre.org/techniques/T1136/

**Office Application Startup**  
https://attack.mitre.org/techniques/T1137/

### Credential Access

**Brute Force**  
https://attack.mitre.org/techniques/T1110/

### Discovery

**Permission Groups Discovery**  
https://attack.mitre.org/techniques/T1069/

## AzureADRecon

> **Note: The AzureADRecon tool is provided by Prashant Mahajan (@prashant3535), thanks for that!**  
https://github.com/adrecon/AzureADRecon

**Installing:** 

Download the tool, the easiest way is to save the .zip file right away.  

<img src="/Azure_Active_Directory/Images/aad_0.png" alt="Download">

> Note: **Attention: It is possible that the antimalware program reacts during the download**  

If you have git installed, you can start by cloning the repository:  

git clone https://github.com/adrecon/AzureADRecon.git

If you downloaded the tool using a zip file, extract the zip file and place it in a location that you can easily find again. If you cloned the repository, a folder was created directly.
Now launch PowerShell or Windows Terminal, whichever you prefer, and navigate to the extract/clone folder.

<img src="/Azure_Active_Directory/Images/wt_1.png" alt="Navigate to the folder">

In order to get started we need one more prerequisite, in my case the PowerShell AzureAD module. However, you are welcome to work with the Microsoft Graph, but this requires additional preparations afterwards.

```
Install-Module AzureAD -Verbose -Force -Allowclobber
```

<img src="/Azure_Active_Directory/Images/wt_2.png" alt="Install AzureAD Module">

Don't forget we need to adjust the execution policy in PowerShell!

```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```

<img src="/Azure_Active_Directory/Images/wt_3.png" alt="Execution Policy">

> **Note: In order to work with this tool, you need to work with an account that has sufficient rights in Entra ID.**  

**To run AzureADRecon (will prompt for credentials)**  

```
PS C:\AzureADRecon-master> .\AzureADRecon.ps1
```

or

```
PS C:\AzureADRecon-master> $username = "your user principal name"
PS C:\AzureADRecon-master> $passwd = ConvertTo-SecureString "your password" -AsPlainText -Force
PS C:\AzureADRecon-master> $creds = New-Object System.Management.Automation.PSCredential ($username, $passwd)
PS C:\AzureADRecon-master> .\AzureADRecon.ps1 -Credential $creds
```

> **Note: To get the report as a spreadsheet, Excel must be installed on the system.**  

**The report is created in the same folder**  

<img src="/Azure_Active_Directory/Images/wt_4.png" alt="Report">

**Now open the report and start the investigation and analysis**  

<img src="/Azure_Active_Directory/Images/aad_1.png" alt="Open the Report">

**User Stats**

<img src="/Azure_Active_Directory/Images/aad_2.png" alt="User Stats">

**Users**  

<img src="/Azure_Active_Directory/Images/aad_3.png" alt="Users">

**Directory Roles**  

<img src="/Azure_Active_Directory/Images/aad_4.png" alt="Directory Roles">

**Directory Roles Members**  

<img src="/Azure_Active_Directory/Images/aad_5.png" alt="Directory Roles Members">

**Devices**  

<img src="/Azure_Active_Directory/Images/aad_6.png" alt="Devices">

## Hunting with Microsoft Sentinel

Now we have detailed information from the Microsoft client. The information was not collected just like that, but because there was a suspicion. Now we continue with advanced hunting in Microsoft Sentinel.

In Microsoft Sentinel, we can directly access the incidents from the overview.

<img src="/Azure_Active_Directory/Images/sen_1.png" alt="Sentinel Incidents">

**List of incidents**

<img src="/Azure_Active_Directory/Images/sen_2.png" alt="List of incidents">

**View full incident details**

<img src="/Azure_Active_Directory/Images/sen_3.png" alt="View full incident details">

**Now the deep dive into the incident**

<img src="/Azure_Active_Directory/Images/sen_4.png" alt="Deep dive">

**Investigate each incident**

<img src="/Azure_Active_Directory/Images/sen_5.png" alt="Investigate">

---
## *HAPPY INVESTIGATING!*
---