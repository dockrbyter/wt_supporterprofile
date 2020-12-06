<#
wt-session_ssh.ps1
.DESCRIPTION

    SSH-Connection Script
    
https://github.com/thelamescriptkiddiemax/wt_supporterprofile
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$defaultsshport = "22"      # SSH Default Port                          EX  22
$scriptspeed = "8"          # Timeout in Sekunden fuer Sessioneustart   EX  10
$fmode = ""                 # Floating Mode (fuer Debugging)            EX  x

#--- Vorbereitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$stringziel = [System.String]::Concat("  Aktuelles Ziel: ", $sshhost, "`n")                                                                                             # SSH Ziel-Einblendung zusammenbauen
$stringreconnect = [System.String]::Concat("`n`n   SSH-EXIT `n   Session-Neustart in: ", $scriptspeed, " Sekunden.`n   Tab schliessen, oder auf Neustart warten...")    # Session-Neustart-Einblendung zusammenbauen

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einbleungen scripthead
function scripthead {

    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    if (!$fmode)                                                                                # Wenn Variable Null dann Screen leeren
    {
        Clear-Host
    }

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
Write-Host "`n"
$sshhost = (Read-Host 'Ziel-Host?')                                                         # SSH Ziel eingeben

scripthead
Write-Host $stringziel -ForegroundColor Green                                               # SSH Ziel-Einblendung zusammenbauen
$sshport = Read-Host "Alternativer SSH-Port? -ENTER fuer Default [$defaultsshport]"         # SSH-Port eigeben - Default-Port: 22

scripthead
Write-Host $stringziel -ForegroundColor Green                                               # SSH Ziel-Einblendung zusammenbauen
$sshuser = (Read-Host 'User?')                                                              # SSH Benutzer eingeben

# Wenn Port-Eingabe null dann $defaultsshport
if ([string]::IsNullOrWhiteSpace($sshport))
{
    $sshport = $defaultsshport
}

# Schleife um Session neuzustarten
while($true)
{
    sessionssh $sshuser $sshhost $sshport $scriptspeed $stringreconnect                     # SSH-Session aufbauen und endlos wiederholen
}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
