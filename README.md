# wt_supporterprofile
Windows Terminal profile for IT supporter. Including SSH, Telnet and Serial sessions.
For detailed informations about Windows Terminal visit https://docs.microsoft.com/en-us/windows/terminal/

All connections are handled by calling PowerShell scripts. Every script has own settings you could edit.
For more information scroll down to "Script Settings".


SSH session:
 - Asks you for target address and user credentials
 - Provides also the possibility to change the SSH port
 - Automatically restarts the session if it fails

Telnet session:
 - Asks you for target address and user credentials
 - Automatically restarts the session if it fails

Serial session:
 - Automatically detects active COM-Port
 - Asks you for baud rate, takes 9600 by default
 - bypasses the values to PuTTY



# Setup
Download the repository an run setup.ps1.

It's a setup script which install things, so yeah, you have to run it as an administrator ;)

The script will install Windows Terminal, if it's not allready on your System.
After that it will create the directorie "WT_SP" at "C:\Users\Public\".
There goes the scripts and the makeup (wallpaer, icons) download.
Finaly it will download and install PuTTY.
You could disable this by removing the value in line 23 in the setup script.
See also the other settings in the lines 21 till 28.

$makeupdl -
The download link for the makeup

$puttysetup -
Disabled the PuTTY setup by leaving blank

$puttylink -
The download link for the PuTTY - Visit their website https://www.putty.org/ for new versions link

$scriptspeed -
Timeout in Seconds until session restart - value example  "10"

$fmode -
Floating Mode - skips the Clear-Host command - value example  "x"



# Shell Settings
PowerShell: Default Shell
CMD: Hidden by default - You could enable it by setting line 83 to "false"
Azure Shell: Hidden by default - You could enable it by setting line 75 to "false"
WSL: Profile will be genreated automatically if WSL-Distribution is installed on your system



# Global Profile Settings
You could edit the global settings from Line 12 until line 29.
If you want to set the default shell for example to CMD, so change line 13 to {0caa0dad-35be-5f56-a8ff-afceeeaa6101}
For more information visit https://docs.microsoft.com/en-us/windows/terminal/customize-settings/global-settings
and https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings



# Key Bindings
Edit the key bindings, like split pane at line 178



# Add Static Connection Profiles
You have two options to make static connection profiles. In booth options you have to add a new profile to the list starting at Line 31.


Option A - quick n' dirty - use the examples below

Edit username addres, tabTidle, etc. according to your environment and paste them to the profile list starting at line 31.
Don't forget to add a "," at the in front of the next profile - of course without "   ;)
You could find these examples also in the settings file itself, starting at line 197

Static Connection Examples:

Static SSH to IP 192.168.178.110
          {
                // SSH Static to SRV-01
                "hidden": false,
                "name": "SSH to SRV-01",
                "tabTitle": "SSH SRV-01",
                "commandline": "ssh root@192.168.178.110",
                "icon": "C:\\Users\\Public\\Pictures\\SupporterTerminal\\icons\\Icon_SSH.ico",
                "backgroundImage": "C:\\Users\\Public\\Pictures\\SupporterTerminal\\wallpaper\\madness.jpg",
                "colorScheme": "Blue Matrix"
          }

  Static SSH to IP 192.168.178.115 on port 202020
          {
                // SSH Static to SRV-05
                "hidden": false,
                "name": "SSH to SRV-05",
                "tabTitle": "SSH SRV-05",
                "commandline": "ssh root@192.168.178.115 -p 202020",
                "icon": "C:\\Users\\Public\\Pictures\\SupporterTerminal\\icons\\Icon_SSH.ico",
                "backgroundImage": "C:\\Users\\Public\\Pictures\\SupporterTerminal\\wallpaper\\madness.jpg",
                "colorScheme": "Blue Matrix"
          }

  Static Telnet to IP 192.168.178.120
          {
                // Telnet Static to SRV-20
                "hidden": false,
                "name": "Telnet to SRV-05",
                "tabTitle": "Telnet SRV-05",
                "commandline": "telnet 192.168.178.120",
                "icon": "C:\\Users\\Public\\Pictures\\SupporterTerminal\\icons\\Icon_Telnet.ico",
                "backgroundImage": "C:\\Users\\Public\\Pictures\\SupporterTerminal\\wallpaper\\morethanthreeofthis.jpg",
                "colorScheme": "Ollie"
          }


Option B - make a copy from the session script

If you want to use the automatically session restart and stuff like that, copy the SSH profile, paste it to the profile list
and edit username address, tabTidle, etc. according to your environment.
Then make a copy from the session script "wt-session_ssh_static_template.ps1" and rename it like "wt-session_ssh_static_SRV-01.ps1" (or what ever you want).
Now go to your new created profile in "settings.json" and change the scriptname in the commandline parameter to the name you have set on you copy.
Finaly edit the variables (lines 10 to 18) in your session script and you good to go. For more information scroll down to "Script Settings".



# Script Settings

wt-session_ssh.ps1 --

$defaultsshport -
SSH Default Port - value example  "22"

$scriptspeed -
Timeout in Seconds until session restart - value example  "10"

$fmode -
Floating Mode - skips the Clear-Host command - value example  "x"


wt-session_telnet.ps1 --

$defaulttelnetport -
Telnet Default Port - value example  "23"

$scriptspeed -
Timeout in Seconds until session restart - value example  "10"

$fmode -
Floating Mode - skips the Clear-Host command - value example  "x"


wt-session_serial.ps1 --

$defaultbaud -
Default Baud Rate                 				value example  "9600"

$fmode -
Floating Mode - skips the Clear-Host command  	value example  "x"

$scriptspeed -
Timeout for the overlays            			value example  "1"


wt-session_ssh_static_template.ps1 --

$sshport -
SSH Port - value example  "22"

$sshhost -
Target Address - value example  "192.168.178.100"

$sshuser -
User Name - value example  "root"

$scriptspeed -
Timeout in Seconds until session restart - value example  "10"

$infospeed -
Timeout in Seconds until session start - value example  "1.5"


wt-session_telnet_static_template.ps1 --

$telnetport -
Telnet Port - value example  "22"

$telnethost -
Target Address - value example  "192.168.178.100"

$scriptspeed -
Timeout in Seconds until session restart - value example  "10"

$infospeed -
Timeout in Seconds until session start - value example  "1.5"



# Color Settings
You could add / remove color themes at line 90.
Shell: PowerShell  Color Theme: "AdventureTime"
Shell: SSH         Color Theme: "Blue Matrix"
Shell: Telnet      Color Theme: "coffee_theme"
Shell: Serial      Color Theme: "MonaLisa"

You could find more awsome color themes at https://windowsterminalthemes.dev/
So feel free to make it your terminal :D

Visit https://imgur.com/a/u1Nn2xy to see the default wallpapers.
Yeah, they look scuffed and used :D
But I'm a technican, not a graphic artist, so feel tree to change them ;)
