#Create a DirectorySearcher object to search Active Directory
$search = New-Object DirectoryServices.DirectorySearcher([ADSI]"")

#Set the filter to search for objects with servicePrincipalName attribute
$search.filter = "(servicePrincipalName=*)"

#Execute the search and get all results
$results = $search.Findall()

#Iterate through each result
foreach($result in $results)
{
    #Get the directory entry for the current result
    $userEntry = $result.GetDirectoryEntry()
    
    #Output the name of the object with specific background and foreground colors
    Write-host "Object Name = " $userEntry.name -backgroundcolor "yellow" -foregroundcolor "black"
    
    #Output the distinguished name of the object
    Write-host "DN      =      "  $userEntry.distinguishedName
    
    #Output the object category
    Write-host "Object Cat. = "  $userEntry.objectCategory
    
    #Output the service principal names
    Write-host "servicePrincipalNames"
    
    $i=1
    
    #Iterate through each service principal name and output it
    foreach($SPN in $userEntry.servicePrincipalName)
    {
        Write-host "SPN(" $i ")   =      " $SPN
        $i+=1
    }
    
    #Output an empty line for better readability
    Write-host ""
}

##########################################################
#This is an onther way to list all SPNs used in the domain
##########################################################

#Import Active Directory module
Import-Module ActiveDirectory

#Retrieve all objects in Active Directory
$objects = Get-ADObject -Filter *

#Iterate through each object
foreach ($object in $objects) {
    #Check if the object is a user account
    if ($object.ObjectClass -eq "user") {
        #Output the distinguished name of the user account
        Write-Host "User account: $($object.DistinguishedName)"
        
        #Check if this is a service account by looking for UserPrincipalName
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
            #No action required if an error occurs
        }
    }
    #Check if this is a computer account
    elseif ($object.ObjectClass -eq "computer") {
        #Output the distinguished name of the computer account
        Write-Host "Computer account: $($object.DistinguishedName)"
    }
}