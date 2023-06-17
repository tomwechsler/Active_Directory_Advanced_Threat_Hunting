#Define needed info
$properties = 'Name','Department','Title','GivenName','SurName'

#Get those users
Get-ADUser -Filter * -Properties * | Format-Table $properties

#We can filter for specific managers
Get-ADUser -Filter {Manager -eq 'Nicholas.Murray'}

#But not empty manager
Get-ADUser -Filter {Manager -eq ''}

#Using an LDAPFilter
Get-ADUser -LDAPFilter "(!manager=*)" -Properties Manager | Format-Table Name,Manager

#Combine both into an LDAP filter
$properties += 'Manager'
$ldapFilter = "(|(!$($properties[0])=*)"
For($x=1;$x -lt $properties.count; $x++){
    $ldapFilter += "(!$($properties[$x])=*)"
}
$ldapFilter += ')'
$ldapFilter

Get-ADUser -LDAPFilter $ldapFilter -Properties $properties | Format-Table $properties