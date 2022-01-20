<#
.SYNOPSIS
    PSS-Connection Script
.DESCRIPTION
    Establishes PowerShell Sessions.
    This script will NOT perform Set-PSSessionConfiguration!
    For more Informations visit:

    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-pssessionconfiguration?view=powershell-5.1
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-pssession?view=powershell-5.1
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-pssessionconfigurationfile?view=powershell-5.1
.EXAMPLE
    PS> .\wt-session_pss.ps1
.LINK
    https://gist.github.com/thelamescriptkiddiemax/6a3bc498a9dd9018e0de6c03cf720ce1#file-readme-md
#>
#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Script head
function scriptheadpss {
    $stringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", ((Get-WmiObject Win32_ComputerSystem).Domain), " ", (Get-CimInstance Win32_OperatingSystem | Select-Object Caption), ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n") 
    $stringhost = $stringhost.replace("{Caption=Microsoft"," ").replace("}", " ")

    Clear-Host
    Write-Host $stringhost -ForegroundColor Magenta
    Write-Host "    ____  ___ " -ForegroundColor Cyan
    Write-Host "   (  _ \/ __)" -ForegroundColor Cyan
    Write-Host "    )___/\__ \" -ForegroundColor Cyan
    Write-Host "   (__)  (___/" -ForegroundColor Cyan
    Write-Host "    ___  ____  ___  ___  ____  _____  _  _ " -ForegroundColor Cyan
    Write-Host "   / __)( ___)/ __)/ __)(_  _)(  _  )( \( )" -ForegroundColor Cyan
    Write-Host "   \__ \ )__) \__ \\__ \ _)(_  )(_)(  )  ( " -ForegroundColor Cyan
    Write-Host "   (___/(____)(___/(___/(____)(_____)(_)\_)" -ForegroundColor Cyan
    Write-Host "`n        PowerShell Session"
}

# PSSession
function sessionpss {  
    scriptheadpss
    $psshost = Read-Host "Target?"              # PSS Target
    Clear-Host                                  # Clear Screen
    
    New-PSSession -ComputerName $psshost        # Establish PSSession
    Start-Sleep -Seconds 5
}

#--- Processing ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Run PSS and run it again on cancel

try {
    sessionpss
}
finally {
    sessionpss
}
