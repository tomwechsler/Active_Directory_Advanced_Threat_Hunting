#Get all permissions in the domain, filtered to the two critical replication permissions represented by their GUIDs
Import-Module ActiveDirectory
cd 'AD:DC=prime,DC=pri' # Replace with distinguished name of your domain
$AllReplACLs = (Get-AcL).Access | Where-Object {$_.ObjectType -eq '1131f6ad-9c07-11d1-f79f-00c04fc2dcd2' -or $_.ObjectType -eq '1131f6aa-9c07-11d1-f79f-00c04fc2dcd2'}

#Filter this list to RIDs above 1000 which will exclude well-known Administrator groups
foreach ($ACL in $AllReplACLs)
{
    $user = New-Object System.Security.Principal.NTAccount($ACL.IdentityReference)
    $SID = $user.Translate([System.Security.Principal.SecurityIdentifier])
    $RID = $SID.ToString().Split("-")[7]
    if([int]$RID -gt 1000)
    {
        Write-Host "Permission to Sync AD granted to:" $ACL.IdentityReference
    }
}