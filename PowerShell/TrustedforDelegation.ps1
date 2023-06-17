#Enable computer and user accounts to be trusted for delegation
https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/enable-computer-and-user-accounts-to-be-trusted-for-delegation

Get-ADComputer -Filter {TrustedforDelegation -eq $true} #(Domaincontroller's are not interesting)

#Event ID 4624
#Successful logins (search for users/service accounts that have logged in to systems that are TrustedforDelegation).
https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4624