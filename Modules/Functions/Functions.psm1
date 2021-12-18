function Set-AuditPolicy {

    auditpol /set /category:*  /failure:enable /success:enable
    Write-Output "Audit Policy Successfully Set"
}

function Set-Users {
    $Secure_String_Pwd = ConvertTo-SecureString "Sandwich1!" -AsPlainText -Force
    foreach ($user in Get-LocalUser)
    {
        if (($user.name -ne "Administrator") -or ($user.name -ne "Guest") -or ($user.name -ne "DefaultAccount"))
        {
            $user | Set-LocalUser -Password $Secure_String_Pwd -PasswordNeverExpires $false
        }
    }
    Write-Output "User Accounts Successfully Set"

}

function Set-Shares {
    Set-Service -Name LanmanServer -StartupType Automatic
    Start-Service LanmanServer
    Remove-SmbShare -Name C
    Remove-SmbShare -Name IPC
    Remove-SmbShare -Name ADMIN
    Remove-SmbShare -Name Users

    Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Any
    Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Public
    Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled False -Profile Public

    Write-Output "Shares Successfully Set"
}

function Set-Firewall {
    #IP Helper
    
    Set-Service -Name MpsSvc -StartupType Automatic
    Start-Service MpsSvc
    Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled True
    Write-Output "Firewall Successfully Set"
}

function Set-SecPol {
    secedit /configure /db secedit.sdb /cfg c:\secpol.cfg /overwrite
    rm -r -force c:\secpol.cfg -confirm:$false

    Write-Output "Security Policy Successfully Set"
}

function Set-Services {
    
    #IP Helper
    Stop-Service iphlpsvc
    Set-Service -Name iphlpsvc -StartupType Disabled

    # Microsoft FTP Service
    Stop-Service ftpsvc
    Set-Service -Name ftpsvc -StartupType Disabled

    #Microsoft iSCSI Initiator Service
    Stop-Service MSiSCSI
    Set-Service -Name MSiSCSI -StartupType Disabled

    #Print Spooler
    Stop-Service Spooler
    Set-Service -Name Spooler -StartupType Disabled
    
    #Offline Files
    Stop-Service CscService
    Set-Service -Name CscService -StartupType Disabled

    #Remote Desktop Configuration
    Stop-Service SessionEnv
    Set-Service -Name SessionEnv -StartupType Disabled

    #Routing and Remote Access
    Stop-Service RemoteAccess
    Set-Service -Name RemoteAccess -StartupType Disabled

    #Remote Desktop Services
    Stop-Service TermService
    Set-Service -Name TermService -StartupType Disabled

    #Remote Desktop Services UserMode
    Stop-Service UmRdpService
    Set-Service -Name UmRdpService -StartupType Disabled

    #Remote Registry
    Stop-Service RemoteRegistry
    Set-Service -Name RemoteRegistry -StartupType Disabled

    #RIP Listener
    Stop-Service iprip
    Set-Service -Name iprip -StartupType Disabled

    #Secondary logon
    Stop-Service seclogon
    Set-Service -Name seclogon -StartupType Disabled

    #Server
    Stop-Service LanmanServer -Force
    Set-Service -Name LanmanServer -StartupType Disabled

    #SNMP Trap
    Stop-Service SNMPTRAP
    Set-Service -Name SNMPTRAP -StartupType Disabled

    #SSDP Discovery
    Stop-Service SSDPSRV
    Set-Service -Name SSDPSRV -StartupType Disabled

    #TCP/Ip NetBIOS Helper
    Stop-Service lmhosts
    Set-Service -Name lmhosts -StartupType Disabled

    #Telnet
    Stop-Service tlntsvr
    Set-Service -Name tlntsvr -StartupType Disabled

    #UPnP Device Host
    Stop-Service upnphost
    Set-Service -Name upnphost -StartupType Disabled

    #World Wide Web Publishing
    Stop-Service W3SVC
    Set-Service -Name W3SVC -StartupType Disabled

    #SNMP Service
    Stop-Service SNMP
    Set-Service -Name SNMP -StartupType Disabled


    #NetTcpPortSharing Service
    Stop-Service NetTcpPortSharing
    Set-Service -Name NetTcpPortSharing -StartupType Disabled

    Write-Output "Services Successfully Set"
}

function Set-Ports {
    New-NetFirewallRule -DisplayName "Block SMB Port" `
                    -Direction Inbound `
                    -LocalPort 139 `
                    -Protocol TCP `
                    -Action Block

    New-NetFirewallRule -DisplayName "Block HTTP Port" `
                    -Direction Inbound `
                    -LocalPort 80 `
                    -Protocol TCP `
                    -Action Block

    New-NetFirewallRule -DisplayName "Block FTP Port" `
                    -Direction Inbound `
                    -LocalPort 21 `
                    -Protocol TCP `
                    -Action Block

    New-NetFirewallRule -DisplayName "Block File and Printing Sharing Port" `
                    -Direction Inbound `
                    -LocalPort 445 `
                    -Protocol TCP `
                    -Action Block

    New-NetFirewallRule -DisplayName "Block Telnet Port" `
                    -Direction Inbound `
                    -LocalPort 23 `
                    -Protocol TCP `
                    -Action Block

    New-NetFirewallRule -DisplayName "Block Chargen Port" `
                    -Direction Inbound `
                    -LocalPort 19 `
                    -Protocol TCP `
                    -Action Block

    New-NetFirewallRule -DisplayName "Block NTP Port" `
                    -Direction Inbound `
                    -LocalPort 123 `
                    -Protocol UDP `
                    -Action Block

    Write-Output "Ports Successfully Set"
}

function Set-Features {
    get-windowsoptionalfeature -online -featurename *Media* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename DirectoryServices-ADAM-Client | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *IIS* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *Print* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename SimpleTCP | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *SMB* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *Telnet* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *RasRip* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *WorkFolders* | disable-windowsoptionalfeature -online -norestart
     
    Write-Output "Features Successfully Set"
    
}

function Set-Misc {
    Set-ItemProperty -Path ‘HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance’-name “fAllowToGetHelp” -Value 0
    Set-ItemProperty -Path ‘HKLM:\System\CurrentControlSet\Control\Terminal Server’-name “fDenyTSConnections” -Value 1
    Write-Output "Other Stuff Successfully Set"

    
}



