###
#A GPO that is either not linked or linked to empty OUs!
###

#Sort OUs with GPO links by whether or not they have non-OU children

#Get all OUs with GPO links:
Get-ADOrganizationalUnit -Filter {LinkedGroupPolicyObjects -like "*"} | Format-Table Name

#For each OU, we need to:
$OU = 'OU=Desktops,OU=Luzern,DC=prime,DC=pri'
Get-ADObject -Filter {ObjectClass -ne 'OrganizationalUnit'} -SearchBase $OU

#Loop through them all
ForEach($OU in Get-ADOrganizationalUnit -Filter {LinkedGroupPolicyObjects -like "*"}){
    $objects = $null
    $objects = Get-ADObject -Filter {ObjectClass -ne 'OrganizationalUnit'} -SearchBase $OU
    If($objects){
        [pscustomobject]@{
            OU = $OU
            Empty = $false
        }
    }Else{
        [pscustomobject]@{
            OU = $OU
            Empty = $true
        }
    }
}

#Yes, functionize that please
Function Get-ADOUStatus {
    param (
        [string]$Filter = '*'
    )
    ForEach($OU in Get-ADOrganizationalUnit -Filter $Filter){
        $objects = $null
        $objects = Get-ADObject -Filter {ObjectClass -ne 'OrganizationalUnit'} -SearchBase $OU
        If($objects){
            [pscustomobject]@{
                OU = $OU
                Empty = $false
                LinkedGPOs = [bool]$OU.LinkedGroupPolicyObjects
            }
        }Else{
            [pscustomobject]@{
                OU = $OU
                Empty = $true
                LinkedGPOs = [bool]$OU.LinkedGroupPolicyObjects
            }
        }
    }
}

#Usage
Get-ADOUStatus

#Find GPOs linked to those empty OUs

#Store the OU status in a variable
$emptyOUs = Get-ADOUStatus | Where-Object {$_.Empty -and $_.LinkedGPOs}

#Get the linked GPO Guids
$emptyOUs[0].OU.LinkedGroupPolicyObjects

#Convert it to a GPO
$emptyOUs[0].OU.LinkedGroupPolicyObjects[0].Substring(4,36)
#Or regex
$emptyOUs[0].OU.LinkedGroupPolicyObjects[0] -match '^cn=\{(?<guid>[^\{\}]+)\}'
$Matches.guid

Get-GPO -Guid $emptyOUs[0].OU.LinkedGroupPolicyObjects[0].Substring(4,36)

#Object to build output
$GPOsLinkedToEmptyOUs = @()

ForEach($OU in $emptyOUs.OU){
    ForEach($GPOGuid in $OU.LinkedGroupPolicyObjects){
        $GPO = Get-GPO -Guid $GPOGuid.Substring(4,36)
        Write-Host "GPO: '$($GPO.DisplayName)' is linked to empty OU: $($OU.Name)"
        If($GPOsLinkedToEmptyOUs.GPOId -contains $GPO.Id){
            ForEach($LinkedGPO in ($GPOsLinkedToEmptyOUs | Where-Object {$_.GPOId -eq $GPO.Id})){
                $LinkedGPO.EmptyOU = [string[]]$LinkedGPO.EmptyOU + "$($OU.DistinguishedName)"
            }
        }Else{
            $GPOsLinkedToEmptyOUs += [PSCustomObject]@{
                GPOName = $GPO.DisplayName
                GPOId = $GPO.Id
                EmptyOU = $OU.DistinguishedName
                NonEmptyOU = ''
            }
        }
    }
}

#result
$GPOsLinkedToEmptyOUs | Format-List

#Check if those GPOs are linked to any OUs with children
$nonEmptyOUs = Get-ADOUStatus | Where-Object {-not $_.Empty}
ForEach($OU in $nonEmptyOUs.OU){
    ForEach($GPO in $GPOsLinkedToEmptyOUs){
        ForEach($GPOGuid in $OU.LinkedGroupPolicyObjects){
            If($GPOGuid.Substring(4,36) -eq $GPO.GPOId){
                Write-Host "GPO: '$($GPO.GPOName)' also linked to non-empty OU: $($OU.Name)"
                If($GPO.NonEmptyOU){
                    $GPO.NonEmptyOU = [string[]]$GPO.NonEmptyOU + $OU.DistinguishedName
                }Else{
                    $GPO.NonEmptyOU = $OU.DistinguishedName
                }
            }
        }
    }
}

#Now
$GPOsLinkedToEmptyOUs | Format-List

#Bring it all together into a function with useful output
Function Get-GPOStatus {
    [cmdletbinding()]
    Param()
    Function Get-ADOUStatus {
        param (
            [string]$Filter = '*'
        )
        ForEach($OU in Get-ADOrganizationalUnit -Filter $Filter){
            $objects = $null
            $objects = Get-ADObject -Filter {ObjectClass -ne 'OrganizationalUnit'} -SearchBase $OU
            If($objects){
                [pscustomobject]@{
                    OU = $OU
                    Empty = $false
                    LinkedGPOs = [bool]$OU.LinkedGroupPolicyObjects
                }
            }Else{
                [pscustomobject]@{
                    OU = $OU
                    Empty = $true
                    LinkedGPOs = [bool]$OU.LinkedGroupPolicyObjects
                }
            }
        }
    }
    $OUs = Get-ADOUStatus | Where-Object {$_.LinkedGPOs}
    $GPOsLinkedToEmptyOUs = @()
    ForEach($OU in ($OUs | Where-Object {$_.empty}).OU){
        ForEach($GPOGuid in $OU.LinkedGroupPolicyObjects){
            $GPO = Get-GPO -Guid $GPOGuid.Substring(4,36)
            Write-Verbose "GPO: '$($GPO.DisplayName)' is linked to empty OU: $($OU.Name)"
            If($GPOsLinkedToEmptyOUs.GPOId -contains $GPO.Id){
                ForEach($LinkedGPO in ($GPOsLinkedToEmptyOUs | Where-Object {$_.GPOId -eq $GPO.Id})){
                    $LinkedGPO.EmptyOU = [string[]]$LinkedGPO.EmptyOU + "$($OU.DistinguishedName)"
                }
            }Else{
                $GPOsLinkedToEmptyOUs += [PSCustomObject]@{
                    GPOName = $GPO.DisplayName
                    GPOId = $GPO.Id
                    EmptyOU = $OU.DistinguishedName
                    NonEmptyOU = ''
                }
            }
        }
    }
    ForEach($OU in ($OUs | Where-Object {-not $_.empty}).OU){
        ForEach($GPO in $GPOsLinkedToEmptyOUs){
            ForEach($GPOGuid in $OU.LinkedGroupPolicyObjects){
                If($GPOGuid.Substring(4,36) -eq $GPO.GPOId){
                    Write-Verbose "GPO: '$($GPO.GPOName)' also linked to non-empty OU: $($OU.Name)"
                    If($GPO.NonEmptyOU){
                        $GPO.NonEmptyOU = [string[]]$GPO.NonEmptyOU + $OU.DistinguishedName
                    }Else{
                        $GPO.NonEmptyOU = $OU.DistinguishedName
                    }
                }
            }
        }
    }
    $GPOsLinkedToEmptyOUs
}

#Usage
Get-GPOStatus -Verbose | Format-List

#Finding unused GPOs
Get-GPOStatus | Where-Object {$_.EmptyOU -and -not $_.NonEmptyOU}