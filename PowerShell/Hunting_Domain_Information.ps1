#Get the current forest in Active Directory
[System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

#Get the current domain in Active Directory
[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()

#Define the root domain of the forest
$ForestRootDomain = 'prime.pri'

#Get all trust relationships for the specified forest
([System.DirectoryServices.ActiveDirectory.Forest]::GetForest((New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Forest', $ForestRootDomain)))).GetAllTrustRelationships()

#Get all trust relationships for the current domain
([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()

#Get all global catalogs in the current forest
[System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().GlobalCatalogs

#Discover Enterprise Services without Network Scanning
Get-adcomputer -filter {ServicePrincipalName -like "*TERMSRV*"} -Properties OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation

Get-adcomputer -filter {ServicePrincipalName -like "*WinRM*"} -Properties OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation

Get-adcomputer -filter {ServicePrincipalName -like "*WinRM*"} -Properties OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation

#Discover Service Accounts
Get-aduser -Filter {ServicePrincipalName -like "*"} -Properties PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation

#Discover Computers without Network Scanning
Get-ADComputer -Filter {PrimaryGroupID -eq "515"} -Properties OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation

#Discover Domain Controllers without Network Scanning
Get-ADComputer -Filter {PrimaryGroupID -eq "516"} -Properties OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation

#Identify Admin Accounts
Get-ADUser -Filter {AdminCount -eq 1} -Properties Name,AdminCount,ServicePrincipalName,PasswordLastSet,LastLogonDate,MemberOf 

#Find Admin Groups
Get-ADGroup -Filter {GroupCategory -eq 'Security' -AND Name -like "*admin*"} 

#Identify Domain Password Policy
Get-ADDefaultDomainPasswordPolicy

#Identify Fine-Grained Password Policies
Get-ADFineGrainedPasswordPolicy -Filter *

#Identify Managed Service Accounts & Group Managed Service Accounts
Get-ADServiceAccount -Filter * -Properties *