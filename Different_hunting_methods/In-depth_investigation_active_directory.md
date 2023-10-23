# In-depth investigation and analysis of the Active Directory with ADRecon!

## As always we start with a list of MITRE techniques:

### Discovery

**Password Policy Discovery**  
https://attack.mitre.org/techniques/T1201/

**Permission Groups Discovery**  
https://attack.mitre.org/techniques/T1069/

**Account Discovery**  
https://attack.mitre.org/techniques/T1087/

### Credential Access

**Steal or Forge Kerberos Tickets**  
https://attack.mitre.org/techniques/T1558

**Steal or Forge Kerberos Tickets: Kerberoasting**  
https://attack.mitre.org/techniques/T1558/003/

### Collection

**Data from Information Repositories**  
https://attack.mitre.org/techniques/T1213/

## Examine the Active Directory without elevated rights!

**I use this account for the investigation**  

- The system used here is a member of the domain (in this example > bot.pri)

```
whoami
```

<img src="/Different_hunting_methods/Images/adrecon_1.png" alt="whoami">

**We are looking for information about the domain**  

```
net user /domain
```

<img src="/Different_hunting_methods/Images/adrecon_2.png" alt="Domain Information">

**We are looking for information about specific accounts**    

```
net user /domain svc1
```

<img src="/Different_hunting_methods/Images/adrecon_3.png" alt="Specific Account Information">

**We are looking for information about specific accounts**    

```
net user /domain svc2
```

<img src="/Different_hunting_methods/Images/adrecon_4.png" alt="Specific Account Information">

## ADRecon

> **Note:The ADRecon tool is provided by Prashant Mahajan (@prashant3535), thanks for that!**  
https://github.com/adrecon/ADRecon

Download the tool, the easiest way is to save the .zip file right away. Attention: The download may cause the anti-malware to react.  

<img src="/Different_hunting_methods/Images/adrecon_5.png" alt="Download">

**Unzip the file, open PowerShell and move into the extracted folder**  

<img src="/Different_hunting_methods/Images/adrecon_6.png" alt="Unzip">

**Set the execution policy to unrestricted**  

<img src="/Different_hunting_methods/Images/adrecon_7.png" alt="Execution Policy">

**Run ADRecon**  

<img src="/Different_hunting_methods/Images/adrecon_8.png" alt="Run ADRecon">

> **Note: To get the report as a spreadsheet, Excel must be installed on the system.**  

**The report is created in the same folder**  

<img src="/Different_hunting_methods/Images/adrecon_9.png" alt="Report">