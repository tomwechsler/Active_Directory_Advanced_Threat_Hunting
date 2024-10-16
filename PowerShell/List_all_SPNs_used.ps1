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