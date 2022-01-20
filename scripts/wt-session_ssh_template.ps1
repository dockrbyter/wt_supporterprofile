<#
.SYNOPSIS
    SSH-Connection Script template
.DESCRIPTION
    Template for static SSH profiles in WindowsTerminal
.EXAMPLE
    wt-session_ssh_template.ps1
.LINK
    https://gist.github.com/thelamescriptkiddiemax/6a3bc498a9dd9018e0de6c03cf720ce1#file-readme-md
#>
#--- Variablen ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$script:sshhost = "0.0.0.0"                # Target Address                            EX  192.168.178.100
$script:sshport = "22"                     # SSH Port                                  EX  22
$script:sshuser = "root"                   # User Name                                 EX  root

#--- Funktionen ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# SSH Session
function sessionssh ($script:sshhost, $script:sshport, $script:sshuser) {

    ssh $script:sshuser@$script:sshhost -p $script:sshport           # SSH Session aufbauen
}

#--- Processing ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

try {
    sessionssh $script:sshhost $script:sshport $script:sshuser
}
finally {
    sessionssh $script:sshhost $script:sshport $script:sshuser
}