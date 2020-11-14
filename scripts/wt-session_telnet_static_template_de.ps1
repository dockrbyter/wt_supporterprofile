<#
wt-session_telnet_static_template.ps1
.DESCRIPTION

    Telnet-Connection Script template
    
https://github.com/thelamescriptkiddiemax/wt_supporterprofile
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$telnetport = "22"                      # Telnet Port                               EX  22
$telnethost = "192.168.178.100"         # Target Address                            EX  192.168.178.100

$scriptspeed = "8"                      # Timeout in Sekunden fuer Sessio Neustart  EX  10
$infospeed = "1.5"                      # Timeout in Sekunden fuer Textausegabe     EX  1.5

#--- Vorbereitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$stringziel = [System.String]::Concat("`n  Ziel: ", $telnethost, "`n   Port: ", $telnetport, "`n   ...starte Session...")                                                   # Telnet Ziel-Einblendung zusammenbauen
$stringreconnect = [System.String]::Concat("`n`n   Telnet-EXIT `n   Session-Neustart in: ", $scriptspeed, " Sekunden.`n   Tab schliessen, oder auf Neustart warten...")     # Session-Neustart-Einblendung zusammenbauen

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einblendungen scripthead
function scripthead {

    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

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

    Clear-Host                                                                                  # Screen leeren

    New-Object –TypeName System.Net.Sockets.TCPClient –ArgumentList $telnethost,$telnetport     # Telnet Session aufbauen

    Write-Host $stringreconnect                                                                 # Auf Session-Neustart hinweisen
    Start-Sleep -Seconds $scriptspeed                                                           # Session Timeout

}

#--- Verarbeitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

scripthead
Write-Host $stringziel -ForegroundColor Green                                                   # Telnet Ziel-Einblendung
Start-Sleep - $infospeed                                                                        # Timeout Telnet Ziel-Einblendung

# Schleife um Session neuzustarten
while($true)
{
    sessiontelnet $telnethost $telnetport $scriptspeed $stringreconnect                         # Telnet-Session aufbauen und endlos wiederholen
}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
