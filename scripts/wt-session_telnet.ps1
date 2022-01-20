<#
.SYNOPSIS
    Telnet connection script
.DESCRIPTION
    Establishes telnet session
.EXAMPLE
    wt-session_telnet.ps1
.LINK
    https://gist.github.com/thelamescriptkiddiemax/6a3bc498a9dd9018e0de6c03cf720ce1#file-readme-md
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$defaulttelnetport = 23         # Telnet Default Port                       e.g.    23
$scriptspeed = 5                # Time to wait for next connection          e.g.    5

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einbleungen scripthead
function scripthead {

    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    Clear-Host
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
$telnethost = (Read-Host 'Target-Host?')                                                            # Telnet Ziel eingeben

scripthead
Write-Host $stringziel -ForegroundColor Green                                                       # Telnet Ziel-Einblendung zusammenbauen
$telnetport = Read-Host "Alternative Telnet-Port? -ENTER for Default [$defaulttelnetport]"          # Telnet-Port eigeben - Default-Port: 22

# Wenn Port-Eingabe null dann $defaulttelnetport
if (!$telnetport)
{
    $telnetport = $defaulttelnetport
}

$stringziel = [System.String]::Concat("  Destination: ", $telnethost, "`n ")                        # Telnet Ziel-Einblendung zusammenbauen
$stringreconnect = [System.String]::Concat("`n`n   Telnet-EXIT `n   Session restart in: ", $scriptspeed, " Seconds.`n   Close Tab or wait for restart...")              # Session-Neustart-Einblendung zusammenbauen

# Schleife um Session neuzustarten
while($true)
{
    sessiontelnet $telnethost $telnetport $scriptspeed $stringreconnect                             # Telnet-Session aufbauen und endlos wiederholen
}
