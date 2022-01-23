<#
.SYNOPSIS
    Serial-Connection Script
.DESCRIPTION
    PowerShell script to call Putty with a serial session.
    Make shure Putty is installed ;)
.EXAMPLE
    PS> .\wt-session_serial.ps1
.LINK
    https://github.com/thelamescriptkiddiemax/wt_supporterprofile
#>
#--- Variables ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$SCRIPT:defaultbaud = 9600          # Default Baud Rate                 e.g.    9600
$SCRIPT:dabi = 8                    # Default Data Bits                 e.g.    8
$SCRIPT:stobi = 1                   # Default Stop Bits                 e.g.    1
$SCRIPT:pari = "n"                  # Parity                            e.g.    n
$SCRIPT:flco = "N"                  # Flow control                      e.g.    N

#--- Functions -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function scripthead {
    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    Clear-Host
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

function puttyseri ($SCRIPT:defaultbaud, $SCRIPT:dabi, $SCRIPT:stobi, $SCRIPT:pari, $SCRIPT:flco) {
    $serialport = [System.IO.Ports.SerialPort]::getportnames()

    if (!$serialport) {                                                                                                                                 # Restart Script if there is no active COM-Port
        scripthead
        Write-Host "       CAN'T FIND ANY ACTIVE COM-PORT! `n       Check your connection! `n" -ForegroundColor White
        Write-Host "    Bitte schliessen Sie diesen Tab und oeffnen ihn nach Wiederherstellung der Verbindung erneut." -ForegroundColor White

        Start-Sleep -Seconds 20                                                                                                                         # Wait some seconds
        Clear-Host
        Write-Host "   Next try..."
        puttyseri $SCRIPT:defaultbaud $SCRIPT:dabi $SCRIPT:stobi $SCRIPT:pari $SCRIPT:flco
    }

    $stringziel = [System.String]::Concat("`n  Active COM-Port: ", $serialport, "`n")

    scripthead
    Write-Host $stringziel                                                                                                                              # Show active COM-Port
    Write-Host "   Baudrates:"
    Write-Host "   110, 300, 600, 1200, 2400, 4800, 9600, 14400, 19200, 38400, 57600, 115200, 128000, 256000"                                           # Show baud rates
    $baudspeed = Read-Host "Baudrate? -ENTER for Default [$SCRIPT:defaultbaud]"                                                                         # Enter baud rate

    if (!$baudspeed){                                                                                                                                   # Set default baud rate if there was no input
        $baudspeed = $SCRIPT:defaultbaud
    }

    scripthead
    Write-Host "`n  Active COM-Port: " -NoNewline -ForegroundColor Yellow; Write-Host $serialport -NoNewline -ForegroundColor Red; Write-Host " Baudrate: " -NoNewline -ForegroundColor Yellow; Write-Host $baudspeed -ForegroundColor Red
    Write-Host "`n`n  Calling Putty...`n" -ForegroundColor Cyan
    Start-Sleep -Seconds 2

    putty.exe -sercfg $baudspeed,$SCRIPT:dabi,$SCRIPT:pari,$SCRIPT:stobi,$SCRIPT:flco -serial $serialport                                               # Call Putty
    Start-Sleep -Seconds 3
    Write-Host "   Connection established!   " -ForegroundColor Green -BackgroundColor White
    Start-Sleep -Seconds 2
    Exit
}

#--- Processing ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

puttyseri $SCRIPT:defaultbaud $SCRIPT:dabi $SCRIPT:stobi $SCRIPT:pari $SCRIPT:flco
