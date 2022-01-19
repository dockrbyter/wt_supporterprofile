# wt_supporterprofile
Windows Terminal profile for IT supporter.
Including SSH, Telnet and PuTTY bypass for Serial sessions.

For detailed informations about 
Windows Terminal visit https://docs.microsoft.com/en-us/windows/terminal/

All connections are handled by calling PowerShell scripts. 
Every script has own settings you could edit.


SSH session:
 - Asks you for target address and user credentials
 - Provides also the possibility to change the SSH port
 - Automatically restarts the session if it fails

Telnet session:
 - Asks you for target address and user credentials
 - Automatically restarts the session if it fails



# Setup
Download the repository an run setup.ps1 as administrator. 
This will override your PowerShell profile! This could be found at 
'%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'. 
If this file not exits, you have nothing to lose.



# Add Static Connection Profiles
You have two options to make static connection profiles. In booth options you have to add a new profile to the list starting at Line 31.

## Option A - quick n' dirty - use the examples below

Edit username addres, tabTidle, etc. according to your environment and paste them to the profile list starting at line 31.
Don't forget to add a "," at the in front of the next profile - of course without "   ;)
You could find these examples also in the settings file itself, starting at line 197

#### Static Connection Examples:
```
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
                "colorScheme": "Ollie"
          }

```

## Option B - make a copy from the session script
```
If you want to use the automatically session restart and stuff like that, copy the SSH profile, paste it to the profile list
and edit username address, tabTidle, etc. according to your environment.
Then make a copy from the session script "wt-session_ssh_static_template.ps1" and rename it like "wt-session_ssh_static_SRV-01.ps1" (or what ever you want).
Now go to your new created profile in "settings.json" and change the scriptname in the commandline parameter to the name you have set on you copy.
Finaly edit the variables (lines 10 to 18) in your session script and you good to go. For more information scroll down to "Script Settings".
```
