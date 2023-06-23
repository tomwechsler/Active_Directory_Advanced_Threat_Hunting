#Define the path to the AdminSDHolder container
$adminSDHolderPath = "CN=AdminSDHolder,CN=System," + (Get-ADRootDSE).rootDomainNamingContext

#Get the ACLs for the AdminSDHolder container
$acl = Get-Acl -Path "AD:\$adminSDHolderPath"

#Output the ACLs
Write-Host "AdminSDHolder ACLs:"
foreach ($ace in $acl.Access) {
    Write-Host "`tIdentity: $($ace.IdentityReference)"
    Write-Host "`t\tAccessControlType: $($ace.AccessControlType)"
    Write-Host "`t\tRights: $($ace.ActiveDirectoryRights)"
    Write-Host "`t\tIsInherited: $($ace.IsInherited)"
}

#Get the SDProp configuration
$sdpropConfig = Get-ADObject -Filter 'objectClass -eq "samDomain"' -Property ntsecuritydescriptor

#Output of the SDProp configuration
Write-Host "SDProp-Configuration:"
Write-Host "`tOwner: $($sdpropConfig.ntsecuritydescriptor.Owner)"
Write-Host "`tGroup: $($sdpropConfig.ntsecuritydescriptor.Group)"

#Get the SDProp execution frequency from the PDC's registry.
$pdc = (Get-ADDomainController -Discover -Service PrimaryDC).HostName
$sdpropFrequency = Invoke-Command -ComputerName $pdc -ScriptBlock {
    Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" -Name "AdminSDProtectFrequency" | Select-Object -ExpandProperty "AdminSDProtectFrequency"
}

#Output of the SDProp execution frequency
Write-Host "SDProp is executed every $([int]$sdpropFrequency[0]) seconds".