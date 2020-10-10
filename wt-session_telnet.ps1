<#
wt-session_telnet.ps1
.DESCRIPTION

    Telnet-Connection Script
    
https://github.com/thelamescriptkiddiemax/wt_supporterprofile
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$defaulttelnetport = "23"           # Telnet Default Port                       EX  23
$scriptspeed = "8"                  # Timeout in Sekunden fuer Sessioneustart   EX  10
$fmode = ""                         # Floating Mode (fuer Debugging)            EX  x

#--- Vorbereitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$stringziel = [System.String]::Concat("  Aktuelles Ziel: ", $telnethost, "`n")                                                                                             # Telnet Ziel-Einblendung zusammenbauen
$stringreconnect = [System.String]::Concat("`n`n   Telnet-EXIT `n   Session-Neustart in: ", $scriptspeed, " Sekunden.`n   Tab schliessen, oder auf Neustart warten...")    # Session-Neustart-Einblendung zusammenbauen

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einbleungen
function scripthead {

    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    if (!$fmode) {
        Clear-Host
    }

    Write-Host $stringhost -ForegroundColor Magenta

    Write-Host "    ____  ____  __    _  _  ____  ____ " -ForegroundColor Red
    Write-Host "   (_  _)( ___)(  )  ( \( )( ___)(_  _)" -ForegroundColor Red
    Write-Host "     )(   )__)  )(__  )  (  )__)   )(  " -ForegroundColor Red
    Write-Host "    (__) (____)(____)(_)\_)(____) (__) " -ForegroundColor Red
    Write-Host "    ___  ____  ___  ___  ____  _____  _  _ " -ForegroundColor Red
    Write-Host "   / __)( ___)/ __)/ __)(_  _)(  _  )( \( )" -ForegroundColor Red
    Write-Host "   \__ \ )__) \__ \\__ \ _)(_  )(_)(  )  ( " -ForegroundColor Red
    Write-Host "   (___/(____)(___/(___/(____)(_____)(_)\_)" -ForegroundColor Red

    Write-Host "`n"

}

# Telnet Session
function sessiontelnet ($telnethost, $telnetport, $scriptspeed, $stringreconnect) {

    Clear-Host                                                                                      # Screen leeren

    New-Object –TypeName System.Net.Sockets.TCPClient –ArgumentList $telnethost,$telnetport         # Telnet Session aufbauen

    Write-Host $stringreconnect                                                                     # Auf Session-Neustart hinweisen
    Start-Sleep -Seconds $scriptspeed                                                               # Session Timeout

}

#--- Verarbeitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

scripthead
Write-Host "`n"
$telnethost = (Read-Host 'Ziel-Host?')                                                              # Telnet Ziel eingeben

$stringziel = [System.String]::Concat("  Aktuelles Ziel: ", $telnethost, "`n ")                     # Telnet Ziel-Einblendung zusammenbauen

scripthead
Write-Host $stringziel -ForegroundColor Green                                                       # Telnet Ziel-Einblendung zusammenbauen
$telnetport = Read-Host "Alternativer Telnet-Port? -ENTER fuer Default [$defaulttelnetport]"        # Telnet-Port eigeben - Default-Port: 22

# Wenn Port-Eingabe null dann $defaulttelnetport
if ([string]::IsNullOrWhiteSpace($telnetport))
{
    $telnetport = $defaulttelnetport
}

# Schleife um Session neuzustarten
while($true)
{
    sessiontelnet $telnethost $telnetport $scriptspeed $stringreconnect                             # Telnet-Session aufbauen und endlos wiederholen
}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
