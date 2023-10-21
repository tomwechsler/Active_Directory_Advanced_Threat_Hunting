# Advanced hunting for group policy settings!

## We start with a list of MITRE techniques:

**Domain Policy Modification**  
https://attack.mitre.org/techniques/T1484/

**Domain Policy Modification: Group Policy Modification**  
https://attack.mitre.org/techniques/T1484/001/

**Group Policy Discovery**  
https://attack.mitre.org/techniques/T1615/

**Domain Policy Modification: Domain Trust Modification**  
https://attack.mitre.org/techniques/T1484/002/

**Unsecured Credentials: Group Policy Preferences**  
https://attack.mitre.org/techniques/T1552/006/

## The Windows Event ID's for the MITRE techniques!

**Domain Policy Modification**  

4739(S): Domain Policy was changed  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4739

**Group Policy Discovery**  
Appendix L: Events to Monitor  
https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/appendix-l--events-to-monitor

**Domain Policy Modification: Domain Trust Modification**  
4716(S): Trusted domain information was modified  
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4716



## Compare the Default Domain Controllers Policy with the security baselines using the Policy Analyzer!

**Security Compliance Toolkit and Baselines**  
https://www.microsoft.com/en-us/download/details.aspx?id=55319  

**So that we can compare the Default Domain Controllers Policy, we create a backup**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_0" alt="Create a backup">

**We need the necessary tools and baselines**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_1" alt="Choose the dowmload">

**Extract the files**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_2" alt="Extract the files">

**From the Windows-Server-2022-Security-Baseline-FINAL folder, copy the following file**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_3" alt="Copy the file">

**Paste the file in the Policy Analyzer folder**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_4" alt="Paste the file">

**Open the Policy Analyzer**

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_5" alt="Open the Policy Analyzer">

> Note: If you have a low screen resolution you may not be able to see the bottom part of the application. It is important that you see the bottom part so that you can adjust the path to the policy rule sets (see red marker).

**Now we have to add the default domain controller policy**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_6" alt="Add the default domain controller policy">

**Click on the import button**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_7" alt="Import the policy">

**Give it a name and then click on safe**  

<img src="/Security_compliance_toolkit_and_baselines/Images/pol_8" alt="Give it a name">

