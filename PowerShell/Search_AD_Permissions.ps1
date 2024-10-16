Import-Module ActiveDirectory -WarningAction SilentlyContinue
# force use of specified credentials everywhere
$creds=Get-Credential
$PSDefaultParameterValues = @{"*-AD*:Credential"=$creds}

#GET DC Name
$dcname=(Get-ADDomainController).Name
New-PSDrive -Name ADDS -PSProvider ActiveDirectory -Server $dcname -Root //RootDSE/ -Credential $creds
Set-Location ADDS:

$OUs  = @(Get-ADDomain | Select-Object -ExpandProperty DistinguishedName)
$OUs += Get-ADOrganizationalUnit -Filter * | Select-Object -ExpandProperty DistinguishedName
$OUs += Get-ADObject -SearchBase (Get-ADDomain).DistinguishedName -SearchScope OneLevel -LDAPFilter '(objectClass=container)' | Select-Object -ExpandProperty DistinguishedName

$domain = (Get-ADDomain).Name

#'NT AUTHORITY\SYSTEM', 'S-1-5-32-548', 'NT AUTHORITY\SELF'
$groups_to_ignore = ( "$domain\Enterprise Admins", "$domain\Domain Admins")


ForEach ($OU in $OUs) {
    $report += Get-Acl -Path "AD:\$OU" |
     Select-Object -ExpandProperty Access | ? {$_.IdentityReference -match "$domain*" -and $_.IdentityReference -notin $groups_to_ignore} |
     Select-Object @{name='organizationalUnit';expression={$OU}}, `
                   @{name='objectTypeName';expression={if ($_.objectType.ToString() -eq '00000000-0000-0000-0000-000000000000') {'All'} Else {$schemaIDGUID.Item($_.objectType)}}}, `
                   @{name='inheritedObjectTypeName';expression={$schemaIDGUID.Item($_.inheritedObjectType)}}, `
                   *
}

$filterrep= $report | Where-Object {-not $_.IsInherited}

Write-Output ( $filterrep | Select-Object OrganizationalUnit,ObjectTypeName,ActiveDirectoryRights,IdentityReference | Format-Table | Out-String)
