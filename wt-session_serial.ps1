<#
wt-session_serial.ps1
.DESCRIPTION

    Serial-Connection Script
    
https://github.com/thelamescriptkiddiemax/wt_supporterprofile
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$defaultbaud = "9600"           # Default Baud Rate                 EX  9600
$fmode = ""                     # Floating Mode (fuer Debugging)    EX  x
$scriptspeed = "2"              # Dauer der Einbledungen            EX  1


$serialport = [System.IO.Ports.SerialPort]::getportnames()

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einblendungen
function scripthead {

    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    if (!$fmode) {
        Clear-Host
    }

    Write-Host $stringhost -ForegroundColor Magenta

    Write-Host "    ___  ____  ____  ____    __    __ " -ForegroundColor Blue
    Write-Host "   / __)( ___)(  _ \(_  _)  /__\  (  )" -ForegroundColor Blue
    Write-Host "   \__ \ )__)  )   / _)(_  /(__)\  )(__ " -ForegroundColor Blue
    Write-Host "   (___/(____)(_)\_)(____)(__)(__)(____)" -ForegroundColor Blue
    Write-Host "    ___  ____  ___  ___  ____  _____  _  _ " -ForegroundColor Blue
    Write-Host "   / __)( ___)/ __)/ __)(_  _)(  _  )( \( )" -ForegroundColor Blue
    Write-Host "   \__ \ )__) \__ \\__ \ _)(_  )(_)(  )  ( " -ForegroundColor Blue
    Write-Host "   (___/(____)(___/(___/(____)(_____)(_)\_)" -ForegroundColor Blue

    Write-Host "`n"

}

# Serial Session
function sessionserial ($comport, $baudspeed) {
    
    Clear-Host
    
    $port= new-Object System.IO.Ports.SerialPort $serialport,$baudspeed,None,8,one
    $port.Open()
    do {
        $textline = $port.ReadLine()
        Write-Host $textline
    }
    while ($port.IsOpen)
}

#--- Verarbeitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if (!$serialport) {
    
    scripthead
    Write-Host "       KEINE COM-VERBINDUNG GEFUNDEN! `n       Verbindung pruefen! `n" -ForegroundColor White
    Write-Host "    Bitte schliessen Sie diesen Tab und oeffnen ihn nach Wiederherstellung der Verbindung erneut." -ForegroundColor White

    Start-Sleep -Seconds 30
    Exit
}

$stringziel = [System.String]::Concat("`n  Aktiver COM-Port: ", $serialport, "`n")

scripthead
Write-Host $stringziel
Write-Host "   Baudrates (bits per second):"
Write-Host "   110, 300, 600, 1200, 2400, 4800, 9600, 14400, 19200, 38400, 57600, 115200, 128000, 256000"
$baudspeed = Read-Host "Baudrate? -ENTER fuer Default [$defaultbaud]"
# Wenn Baud-Eingabe null dann $defaultbaud
if ([string]::IsNullOrWhiteSpace($baudspeed))
{
    $baudspeed = $defaultbaud
}

$stringbaud = [System.String]::Concat("`n  Aktiver COM-Port: ", $serialport,"`n  Baudrate: ", $baudspeed, "`n`n  Baue Verbindung auf...`n")

scripthead
Write-Host $stringbaud
Start-Sleep -Seconds $scriptspeed

sessionserial

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
