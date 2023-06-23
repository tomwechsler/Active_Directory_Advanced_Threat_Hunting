#Import Active Directory module
Import-Module ActiveDirectory

#Retrieve all objects in AD
$objects = Get-ADObject -Filter *

#Go through all objects
foreach ($object in $objects) {
    #Check if the object is a user account
    if ($object.ObjectClass -eq "user") {
        #Output the information
        Write-Host "User account: $($object.DistinguishedName)"

        #Check if this is a service account
        if ($object.UserPrincipalName) {
            Write-Host "`tServiceAccount"
        }

        #Check if the account has service principal names
        try {
            $spn = Get-ADUser $($object.DistinguishedName) -Property ServicePrincipalNames
            if ($spn.ServicePrincipalNames) {
                Write-Host "`tIs a Service Principal Names"
            }
        } catch {
            #No action required
        }
    }
    #Check if this is a computer account
    elseif ($object.ObjectClass -eq "computer") {
        Write-Host "Computer account: $($object.DistinguishedName)"
    }
}