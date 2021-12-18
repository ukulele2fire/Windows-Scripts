if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{
    $arguments = "& '" +$myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

Import-Module Functions

#Set-Shares
Set-Users
#Set-AuditPolicy
#Set-Firewall
#Set-SecPol
#Set-Services
#Set-Ports
#Set-Features
#set-Misc

Write-Output "All Done :)"
Read-Host

