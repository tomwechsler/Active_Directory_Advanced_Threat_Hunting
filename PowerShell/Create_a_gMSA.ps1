#The first step, create the root key

#Use this command in productive environment (Important wait 10h - replication)
Add-KdsRootKey -EffectiveImmediately

#This command is intended for a test environment 
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10)) 

#Create a new group
New-ADGroup -Name TestMSA `
-GroupScope DomainLocal `
-Description "Group for servers of TestMSA" `
-DisplayName "Test gMSA group" `
-GroupCategory Security `
-SAMAccountName TestMSA `
-PassThru

#To this group I now add the "Members
Add-ADGroupMember -Identity TestMSA `
-Members "dc01$","dc02$" `
-PassThru

#Control
Get-ADGroupMember -Identity TestMSA

#Now create a new account
New-ADServiceAccount -Name SvcAcnt1 `
-DNSHostName SvcAcnt1.corp.pri `
-PassThru

#The account will be edited now
Set-ADServiceAccount -Identity SvcAcnt1 `
-PrincipalsAllowedToRetrieveManagedPassword TestMSA `
-PrincipalsAllowedToDelegateToAccount TestMSA `
-PassThru

#Before running this cmdlet, the systems must be restarted (so that group membership is applied)
Invoke-Command -ComputerName dc02 -ScriptBlock {Restart-Computer -Force}

#Install the service account on DC02
Invoke-Command -ComputerName dc02 -ScriptBlock {Install-ADServiceAccount -Identity SvcAcnt1}

#Control
Invoke-Command -ComputerName dc02 -ScriptBlock {Test-ADServiceAccount -Identity SvcAcnt1}

#Now in services we can select this account for a specific service