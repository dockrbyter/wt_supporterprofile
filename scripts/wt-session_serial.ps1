<#
wt-session_serial.ps1
.DESCRIPTION

    Serial-Connection Script
    
https://github.com/thelamescriptkiddiemax/wt_supporterprofile
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

[INT]$defaultbaud = "9600"          # Default Baud Rate                 EX  9600
$fmode = ""                         # Floating Mode (fuer Debugging)    EX  x
$scriptspeed = "5"                  # Dauer der Einbledungen            EX  1


$serialport = [System.IO.Ports.SerialPort]::getportnames()

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einblendungen scripthead
function scripthead {

    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    if (!$fmode)                                                                                # Wenn Variable Null dann Screen leeren
    {
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
function sessionserial ($port) {
    
    $port.Open()                                                                                # Serial Port oeffnen
    $port.ReadExisting()                                                                        # Serial Port auslesen
    $inputcharraw = Read-Host "Eingabe"                                                         # Eingabe von User engegen nehmen
    
    if ([string]::IsNullOrWhiteSpace($inputchar))                                               # Wenn Eingabe null dann ENTER
    {
        $inputchar = {ENTER}
    }else                                                                                       # Else Eingabe in Char umwandeln
    {
        $inputchar = ([byte][char]$inputcharraw)
    }

    $port.Write( $inputchar )                                                                   # Serial Port Eingabe uebermitteln
    $port.ReadExisting()                                                                        # Serial Port auslesen
    $port.Close()                                                                               # Serial Port schliessen

}

#--- Verarbeitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if (!$serialport)                                                                                                                                   # Serial Port nicht verbunden dann Session schliessen
{
    
    scripthead                                                                                                                                      # Scripthead ausgeben
    Write-Host "       KEINE COM-VERBINDUNG GEFUNDEN! `n       Verbindung pruefen! `n" -ForegroundColor White
    Write-Host "    Bitte schliessen Sie diesen Tab und oeffnen ihn nach Wiederherstellung der Verbindung erneut." -ForegroundColor White

    Start-Sleep -Seconds 30                                                                                                                         # Warte 30 Sekunden
    Exit                                                                                                                                            # Schliesse Session
}

$stringziel = [System.String]::Concat("`n  Aktiver COM-Port: ", $serialport, "`n")                                                                  # Ausgabe vorhandene Com Verbindung zusammenbauen

scripthead                                                                                                                                          # Scripthead ausgeben
Write-Host $stringziel                                                                                                                              # Ausgabe vorhandene Com Verbindung
Write-Host "   Baudrates (bits per second):"
Write-Host "   110, 300, 600, 1200, 2400, 4800, 9600, 14400, 19200, 38400, 57600, 115200, 128000, 256000"                                           # Moegliche Baud Rates
[INT]$baudspeed = Read-Host "Baudrate? -ENTER fuer Default [$defaultbaud]"                                                                          # Baud Rate eingeben

if ([string]::IsNullOrWhiteSpace($baudspeed))                                                                                                       # Wenn Baud-Eingabe null dann $defaultbaud
{
    $baudspeed = $defaultbaud
}

$stringbaud = [System.String]::Concat("`n  Aktiver COM-Port: ", $serialport,"`n  Baudrate: ", $baudspeed, "`n`n  Baue Verbindung auf...`n")         # Ausgabe vorhandene Com Verbindung mit Baud Rate zusammenbauen

scripthead                                                                                                                                          # Scripthead ausgeben
Write-Host $stringbaud                                                                                                                              # Ausgabe vorhandene Com Verbindung mit Baud Rate
Start-Sleep -Seconds $scriptspeed                                                                                                                   # Warte Dauer $scriptspeed


$port = new-Object System.IO.Ports.SerialPort                                               # Serial Object erzeugen
$port.PortName = $serialport                                                                # COM Port festlegen
$port.BaudRate = $baudspeed                                                                 # Baud Rate 
$port.Parity = "None"                                                                       # Parity None
$port.DataBits = 8                                                                          # Start Bit Laenge
$port.StopBits = 1                                                                          # Stop Bit Laenge
$port.ReadTimeout = 1000                                                                    # Timeout eine Sekunde


Clear-Host                                                                                                                                          # Screen leeren

while($true)                                                                                                                                        # Endlosschleife
{

    sessionserial $port                                                                                                                             # Serial Daten Ein/Ausgabe
    Start-Sleep -Seconds 1                                                                                                                          # Warte eine Sekunde

}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
