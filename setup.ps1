<#
.SYNOPSIS
    Setup script for the Windows Terminal Supporter Profile
.DESCRIPTION
    This will override your PowerShell - and your Windows Terminal profile!

    RTFM
.EXAMPLE
    PS> .\wtprofilesetup.ps1
.LINK
    https://github.com/thelamescriptkiddiemax/wt_supporterprofile
#>
#--- Variables ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$fthurmit = "hermit.zip"
$flhurmit = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hermit.zip"
$ftdroid = "droid.zip"
$fldroid = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip"

$destfol = [System.String]::Concat($env:USERPROFILE, "\Desktop\WT-PROFILE")
$fontfol = [System.String]::Concat($destfol, "\fonts")
$pspf =  [System.String]::Concat($env:USERPROFILE, "\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1")
$wtp = [System.String]::Concat($env:USERPROFILE, "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json")
$sspa = [System.String]::Concat($PSScriptRoot, "\scripts")
$mspa = [System.String]::Concat($PSScriptRoot, "\makeup")
$pspa = [System.String]::Concat($PSScriptRoot, "\profiles\")
$ppspa = [System.String]::Concat($pspa, "Microsoft.PowerShell_profile.ps1")
$wtpspa = [System.String]::Concat($pspa, "settings.json")
$wtprofpa = [System.String]::Concat($ENV:Public, "\wtprofile")

[double]$scriptspeed = 2 

#--- Functions ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$scriptname = $MyInvocation.MyCommand.Name
# Scripthead
function scripthead {
    # Stringhostinfos
    $tringhost = [System.String]::Concat("[ ", $env:UserName, " @ ", $env:computername, " @ ", (Get-WmiObject Win32_ComputerSystem).Domain, " -", (Get-CimInstance Win32_OperatingSystem).Caption, ": ", 
    ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId), " ]   ", (Get-Date -Format "dd/MM/yyyy HH:mm"), "`n", "[ ", $scriptname, " ]", "`n","`n") 
    $tringhost = $tringhost.replace("Microsoft "," ").replace("}", " ")

   # Clear-Host
    Write-Host $tringhost -ForegroundColor Magenta
    Write-Host "            __                               _____.__.__          " -ForegroundColor Red
    Write-Host " __  _  ___/  |_  ___________________  _____/ ____\__|  |   ____  " -ForegroundColor Red
    Write-Host " \ \/ \/ /\   __\/  ___/\____ \_  __ \/  _ \   __\|  |  | _/ __ \ " -ForegroundColor Red
    Write-Host "  \     /  |  |  \___ \ |  |_> >  | \(  <_> )  |  |  |  |_\  ___/ " -ForegroundColor Red
    Write-Host "   \/\_/   |__| /____  >|   __/|__|   \____/|__|  |__|____/\___  >" -ForegroundColor Red
    Write-Host "                     \/ |__|                                   \/ " -ForegroundColor Red
    Write-Host "                       __     " -NoNewline -ForegroundColor Red; Write-Host ".___.___ " -ForegroundColor Yellow
    Write-Host "   _____ _____ _______|  | __ " -NoNewline -ForegroundColor Red; Write-Host "|   |   |" -ForegroundColor Yellow
    Write-Host "  /     \\__  \\_  __ \  |/ / " -NoNewline -ForegroundColor Red; Write-Host "|   |   |" -ForegroundColor Yellow
    Write-Host " |  Y Y  \/ __ \|  | \/    <  " -NoNewline -ForegroundColor Red; Write-Host "|   |   |" -ForegroundColor Yellow
    Write-Host " |__|_|  (____  /__|  |__|_ \ " -NoNewline -ForegroundColor Red; Write-Host "|___|___|" -ForegroundColor Yellow
    Write-Host "       \/     \/           \/ " -ForegroundColor Red
    Write-Host "`n"
}

# Display timespan
function scriptspeed ($scriptspeed) {
    Start-Sleep -Seconds $scriptspeed
}

function downloader ($durl, $dtarget) {
    Write-Host "   Downloading..."
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile($durl, $dtarget)
}

#--- Processing ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

scripthead
scriptspeed $scriptspeed

#...........................................#
scripthead
Write-Host "...PowerShell installs..."
scriptspeed $scriptspeed

Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module oh-my-posh -Scope CurrentUser
winget install JanDeDobbeleer.OhMyPosh
Install-Module -Name Terminal-Icons -Repository PSGallery

scripthead
Write-Host "...PowerShell installs done!"
scriptspeed $scriptspeed

#...........................................#
scripthead
Write-Host "...Font Downloads..."
scriptspeed $scriptspeed

mkdir $fontfol -Force

$dtarget = [System.String]::Concat($fontfol, "\", $fthurmit)
$durl = $flhurmit
downloader $durl $dtarget

$dtarget = [System.String]::Concat($fontfol, "\", $ftdroid)
$durl = $fldroid
downloader $durl $dtarget

Write-Host " Font download done! A new folder was created on your desktop. Please extract the zip files and install the fonts. Hit Enter in this window when you are done."
Write-Host " (You could delete this folder after that.)"
Start-Process -FilePath C:\Windows\explorer.exe -ArgumentList "/select, ""$dtarget"""
Pause

#...........................................#

scripthead
Write-Host "...move content..."

Copy-Item $ppspa $pspf -PassThru -Force
Copy-Item $wtpspa $wtp -PassThru -Force
Get-ChildItem -path $sspa -recurse | Copy-Item -destination $wtprofpa -PassThru -Force
Get-ChildItem -path $mspa -recurse | Copy-Item -destination $wtprofpa -PassThru -Force

scripthead
Write-Host "...done..."

#...........................................#

scripthead
Write-Host "   Setup finished!" -NoNewline -ForegroundColor Yellow -BackgroundColor White; Write-Host " And now go back to work!" -ForegroundColor DarkRed -BackgroundColor White
Start-Sleep -Seconds 5
