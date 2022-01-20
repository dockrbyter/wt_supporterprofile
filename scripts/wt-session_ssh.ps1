<#
.SYNOPSIS
    SSH-Connection Script
.DESCRIPTION
    PowerShell SSH script for WindowsTerminal
.EXAMPLE
    PS> .\wt-session_ssh.ps1
.LINK
    https://gist.github.com/thelamescriptkiddiemax/6a3bc498a9dd9018e0de6c03cf720ce1#file-readme-md
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$defaultsshport = "22"      # SSH Default Port      EX  22
$defaultuser = "root"       # SSH Default User      EX  root

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Einbleungen scripthead
function scriptheadssh {
    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    Clear-Host
    Write-Host $stringhost -ForegroundColor Magenta
    Write-Host "    ___  ___  _   _ " -ForegroundColor DarkCyan
    Write-Host "   / __)/ __)( )_( )" -ForegroundColor DarkCyan
    Write-Host "   \__ \\__ \ ) _ ( " -ForegroundColor DarkCyan
    Write-Host "   (___/(___/(_) (_)" -ForegroundColor DarkCyan
    Write-Host "    ___  ____  ___  ___  ____  _____  _  _ " -ForegroundColor DarkCyan
    Write-Host "   / __)( ___)/ __)/ __)(_  _)(  _  )( \( )" -ForegroundColor DarkCyan
    Write-Host "   \__ \ )__) \__ \\__ \ _)(_  )(_)(  )  ( " -ForegroundColor DarkCyan
    Write-Host "   (___/(____)(___/(___/(____)(_____)(_)\_)" -ForegroundColor DarkCyan
    Write-Host "`n"
}

# SSH Session
function sessionssh ($defaultsshport, $defaultuser) {
    $sshhost = "IP/HOSTNAME"
    
    scriptheadssh
    Write-Host " TARGET: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshhost -NoNewline -ForegroundColor Red; Write-Host " PORT: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshport -NoNewline -ForegroundColor Red; Write-Host " USER: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshuser -ForegroundColor Red
    $sshhost = Read-Host "Target?"                                                       # SSH Ziel eingeben

    scriptheadssh
    Write-Host " TARGET: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshhost -NoNewline -ForegroundColor Red; Write-Host " PORT: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshport -NoNewline -ForegroundColor Red; Write-Host " USER: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshuser -ForegroundColor Red
    $sshport = Read-Host "SSH-Port? -ENTER for Default [$defaultsshport]"           # SSH-Port eigeben - Default-Port: 22

    # Wenn Port-Eingabe null dann $defaultsshport
    if (!$sshport) {
        $sshport = $defaultsshport
    }
    
    scriptheadssh
    Write-Host " TARGET: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshhost -NoNewline -ForegroundColor Red; Write-Host " PORT: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshport -NoNewline -ForegroundColor Red; Write-Host " USER: " -NoNewline -ForegroundColor DarkCyan; Write-Host $sshuser -ForegroundColor Red
    $sshuser = Read-Host "User? -ENTER for Default [$defaultuser]"                                                              # SSH Benutzer eingeben

    # Wenn user null dann $defaultuser
    if (!$sshuser) {
        $sshuser = $defaultuser
    }
    
    Clear-Host                                  # Screen leeren
    ssh $sshuser@$sshhost -p $sshport           # SSH Session aufbauen
}

#--- Processing ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

try {
    sessionssh $defaultsshport $defaultuser
}
finally {
    sessionssh $defaultsshport $defaultuser
}
