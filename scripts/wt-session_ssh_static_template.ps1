<#
wt-session_ssh.ps1
.DESCRIPTION

    SSH-Connection Script template
    
https://github.com/thelamescriptkiddiemax/powershell
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$sshport = "22"                     # SSH Port                                  EX  22
$sshhost = "192.168.178.100"        # Target Address                            EX  192.168.178.100
$sshuser = "root"                   # User Name                                 EX  root

$scriptspeed = "8"                  # Timeout session restart                   EX  10
$infospeed = "1.5"                  # Text timeout                              EX  1.5

#--- Vorbereitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$stringziel = [System.String]::Concat("`n  Destination: ", $sshhost, "`n   User: ", $sshuser, "`n   ...starting session...")                                                     # SSH Ziel-Einblendung zusammenbauen
$stringreconnect = [System.String]::Concat("`n`n   SSH-EXIT `n   Session restart in: ", $scriptspeed, " seconds.`n   Close Tab or wait for restart...")    # Session-Neustart-Einblendung zusammenbauen

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einblendungen scripthead
function scripthead {

    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    Write-Host $stringhost -ForegroundColor Magenta

    Write-Host "    ___  ___  _   _ " -ForegroundColor White
    Write-Host "   / __)/ __)( )_( )" -ForegroundColor White
    Write-Host "   \__ \\__ \ ) _ ( " -ForegroundColor White
    Write-Host "   (___/(___/(_) (_)" -ForegroundColor White
    Write-Host "    ___  ____  ___  ___  ____  _____  _  _ " -ForegroundColor White
    Write-Host "   / __)( ___)/ __)/ __)(_  _)(  _  )( \( )" -ForegroundColor White
    Write-Host "   \__ \ )__) \__ \\__ \ _)(_  )(_)(  )  ( " -ForegroundColor White
    Write-Host "   (___/(____)(___/(___/(____)(_____)(_)\_)" -ForegroundColor White

    Write-Host "`n"

}

# SSH Session
function sessionssh ($sshuser, $sshhost, $sshport, $scriptspeed, $stringreconnect) {

    Clear-Host                                  # Screen leeren

    ssh $sshuser@$sshhost -p $sshport           # SSH Session aufbauen

    Write-Host $stringreconnect                 # Auf Session-Neustart hinweisen
    Start-Sleep -Seconds $scriptspeed           # Session Timeout

}

#--- Verarbeitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

scripthead
Write-Host $stringziel -ForegroundColor Green                                               # SSH Ziel-Einblendung
Start-Sleep - $infospeed                                                                    # Timeout SSH Ziel-Einblendung

# Schleife um Session neuzustarten
while($true)
{
    sessionssh $sshuser $sshhost $sshport $scriptspeed $stringreconnect                     # SSH-Session aufbauen und endlos wiederholen
}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
