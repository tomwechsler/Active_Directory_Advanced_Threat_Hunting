#Access Token Manipulation: SID-History Injection
https://attack.mitre.org/techniques/T1134/005/

#Security assessment: Unsecure SID History attributes
https://learn.microsoft.com/en-us/defender-for-identity/security-assessment-unsecure-sid-history-attribute

Get-ADUser -Filter * -Properties cn,memberof,sidhistory

Get-ADUser -Properties sidhistory,memberof -Filter {sidhistory -like '*'}