<#
.SYNOPSIS
    Invokes scripts from the web in PowerShell
.DESCRIPTION
    Invokes scripts directly from online ressorces like GitHub. The URL musst point to raw script, no markup, or stuff like that.

    Leave $script:scriptURL blank for interactive use, or just put there your link and save it,
    so you can use it for an autostart-script.
.EXAMPLE
    PS> .\pss-summoner.ps1

    Output: URL to script? (RAW)
    Input:  https://gist.githubusercontent.com/thelamescriptkiddiemax/5df9b3ef23ea10e6ec3cc807063a3c17/raw/9b42d7ac5a14d6768e8a77f3ae90a3e5e6d2c194/sshkeydude.ps1
.LINK
    https://raw.githubusercontent.com/thelamescriptkiddiemax/powershell/master/11aa_VORLAGE.ps1
#>
#--- Variables ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$script:scriptURL = ""

#--- Functions ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function scriptheadpsss ($tringhost)
{
    # String host infos
    $tringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", (Get-WmiObject Win32_ComputerSystem).Domain, " -", (Get-CimInstance Win32_OperatingSystem).Caption, ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm")) 
    $tringhost = $tringhost.replace("Microsoft "," ").replace("}", " ")

    Clear-Host

    Write-Host $tringhost -ForegroundColor Magenta
    Write-Host "                       .          " -ForegroundColor Green
    Write-Host "                     ..      .    " -NoNewline -ForegroundColor Green; Write-Host " ____  ____  ____" -ForegroundColor Cyan
    Write-Host "                ,         ;       " -NoNewline -ForegroundColor Green; Write-Host "(  _ \/ ___)/ ___)" -ForegroundColor Cyan
    Write-Host "               ,  ,      ,,       " -NoNewline -ForegroundColor Green; Write-Host " ) __/\___ \\___ \" -ForegroundColor Cyan
    Write-Host "           .,,*/(/(/@@@/(@@ ,,*   " -NoNewline -ForegroundColor Green; Write-Host "(__)  (____/(____/" -ForegroundColor Cyan
    Write-Host "        @@" -NoNewline -ForegroundColor DarkGray; Write-Host ".**,,,*/*****,*.*.,**" -NoNewline -ForegroundColor Green; Write-Host "@@ " -ForegroundColor DarkGray
    Write-Host "         @@&" -NoNewline -ForegroundColor DarkGray; Write-Host "****,*,**,,****,," -NoNewline -ForegroundColor Green; Write-Host "@@@  " -ForegroundColor DarkGray
    Write-Host "       @@%&&&@@@@@@@@@@@@@%@@@@@  " -NoNewline -ForegroundColor DarkGray; Write-Host " ____  _  _  _  _  _  _   __   __ _  ____  ____" -ForegroundColor Cyan
    Write-Host "        @%%&&&@@@@@@@@@@@@@@@@@@@ " -NoNewline -ForegroundColor DarkGray; Write-Host "/ ___)/ )( \( \/ )( \/ ) /  \ (  ( \(  __)(  _ \" -ForegroundColor Cyan
    Write-Host "        @%%&&&@@@@@@@@@@@@@@@@@@@ " -NoNewline -ForegroundColor DarkGray; Write-Host "\___ \) \/ (/ \/ \/ \/ \(  O )/    / ) _)  )   /" -ForegroundColor Cyan
    Write-Host "         @%&&@@@@@@@@@@@@@@@@@@@  " -NoNewline -ForegroundColor DarkGray; Write-Host "(____/\____/\_)(_/\_)(_/ \__/ \_)__)(____)(__\_)" -ForegroundColor Cyan
    Write-Host "          @&&&@@@@@@@@@@@@@@@@@   " -ForegroundColor DarkGray
    Write-Host "            @@@@@@@@@@@@@@@@" -NoNewline -ForegroundColor DarkGray; Write-Host "," -ForegroundColor Red
    Write-Host "             @" -NoNewline -ForegroundColor DarkGray; Write-Host "..." -NoNewline -ForegroundColor Red; Write-Host "@@@@@@" -NoNewline -ForegroundColor DarkGray; Write-Host "..." -NoNewline -ForegroundColor Red; Write-Host "@" -NoNewline -ForegroundColor DarkGray; Write-Host "..     " -ForegroundColor Red
    Write-Host "                ..........        " -ForegroundColor Red
    Write-Host "`n"
}

function urlinput ($script:scriptURL, $tringhost)
{
    scriptheadpsss $tringhost
    
    # If $criptURL NULL...
    if (!$script:scriptURL) {
        $script:scriptURL = Read-Host -Prompt "   URL to script? (RAW)"        # Enter script URL

        # If $script:scriptURL still NULL...
        if (!$script:scriptURL) {
            scriptheadpsss $tringhost
            Write-Host "   No Input! O.o Try again..." -BackgroundColor White -ForegroundColor Red
            Start-Sleep -Seconds 1
            urlinput $script:scriptURL
        }
    }else {
        $script:pssslbreak = "x"
    }

    psssummon $script:scriptURL
}

function psssummon ($script:scriptURL)
{
    try {
        Clear-Host
        Invoke-Expression $((Invoke-WebRequest $script:scriptURL -UseBasicParsing).Content)
    }
    finally{
        if (!$script:pssslbreak) {
            $script:scriptURL = ""
            Clear-Host
            urlinput $script:scriptURL
        }else {
            Stop-Process
        }
    }
}

#--- Processing ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

urlinput $script:scriptURL $tringhost
