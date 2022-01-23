# wt_supporterprofile
Windows Terminal profile for IT supporter.
Mark II :D
Still including SSH, Telnet and now other nice stuff like OhMyPosh and more...

For detailed informations about 
Windows Terminal visit: https://docs.microsoft.com/en-us/windows/terminal/
For detailed informations about 
OhMyPosh visit: https://ohmyposh.dev/

All connections are handled by calling PowerShell scripts. 
Every script has own settings you could edit. Possibly I will add some more in the future.
So make shure you have edited you PowerShell execution policy to "unrestricted", or something like that...
```
Set-ExecutionPolicy Unrestricted
```

##### PS Script Summoner:
 - Just paste the link to a raw PowerShell script, hit Enter and enjoy
For testing you could try this:
```
https://gist.githubusercontent.com/thelamescriptkiddiemax/5df9b3ef23ea10e6ec3cc807063a3c17/raw/9b42d7ac5a14d6768e8a77f3ae90a3e5e6d2c194/sshkeydude.ps1
```

##### SSH session:
 - Asks you for target address and user credentials
 - Provides also the possibility to change the SSH port
 - Automatically restarts the session if it fails
 - Including a template for your static SSH profiles

##### And much more! :D

# Setup
Make shure Windows Terminal is installed. Then download the repositor, extract the whole folder and run inside wtprofilesetup.ps1 as administrator.
```
.\wtprofilesetup.ps1
```
This will override your Windows Terminal - and also your PowerShell profile! The PowerShell profile could be found at:
```
%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
```
Or just type the following command in yor terminal:
```
notepad $PROFILE
```
If this file not exits, you have nothing to lose. Otherwise better create a backup...

The Windows Terminal profile could be found at:
```
%USERPROFILE%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState
```
If you have done any changes on this file, you should also backup the changes / this file ;)

## Add Static Connection Profiles
You have two options to make static connection profiles in your Windows Terminal. In booth options you have to add a new profile to your settings.json.

### Option A - quick n' dirty - use the examples below
```
Edit username addres, tabTidle, etc. according to your environment and paste them to the profile list.
Don't forget to add a "," at the in front of the next profile - of course without "   ;)
```

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

### Option B - make a copy from the session script
```
If you want to use the automatically session restart and stuff like that, copy the SSH profile, paste it to the profile list
and edit username address, tabTidle, etc. according to your environment.
Then make a copy from the session script "wt-session_ssh_static_template.ps1" and rename it like "wt-session_ssh_static_SRV-01.ps1" (or what ever you want).
Now go to your new created profile in "settings.json" and change the scriptname in the commandline parameter to the name you have set on you copy.
Finaly edit the variables in your session script and you good to go.
```

## Makeup Settings
The Windows Terminal has evolved and now you could do the most settings in the app itself. For anything else you have to open the settings.json.
If you don't like the icons, wallpapers, ... - feel free to change it :D
Everthing will be stored in:
```
%public%\wtprofile
```

You could also change the default OhMyPosh theme in your PowerShell profile:
```
notepad $PROFILE
```

## Tab Profiles
Feel free to chage the values of any tab profiles property "hidden". So you could show and hide some features like the CMD shell, which is by default hidden.

    },
    ...
    "hidden": true,
    ...
    }

### Hidden Profiles
 - CMD
 - Telnet
 - Serial
 - PowerShell Session

## Relevant Links
https://docs.microsoft.com/en-us/windows/terminal/
https://docs.microsoft.com/en-us/windows/terminal/tutorials/custom-prompt-setup
https://docs.microsoft.com/en-us/windows/terminal/samples
https://docs.microsoft.com/en-us/windows/terminal/panes

https://ohmyposh.dev/
https://ohmyposh.dev/docs/windows

https://windowsterminalthemes.dev/

https://www.nerdfonts.com/font-downloads
https://fonts.google.com/icons
https://pixabay.com/de/photos/glas-scifi-violett-ultraviolet-3389935/
https://cliply.co/clip/static-noise/

https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701#activetab=pivot:overviewtab
