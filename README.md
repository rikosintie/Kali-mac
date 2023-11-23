# Kali-mac<!-- omit from toc -->

- [Initial Installation](#initial-installation)
  - [Creating the bootable flash drive](#creating-the-bootable-flash-drive)
  - [Repartioning the hard drive](#repartioning-the-hard-drive)
- [A Couple Guides to help you with Linux](#a-couple-guides-to-help-you-with-linux)
  - [Ubuntu for Network Engineers](#ubuntu-for-network-engineers)
  - [The Hackers Choice](#the-hackers-choice)
- [Installed software](#installed-software)
  - [Oh My ZSH](#oh-my-zsh)
    - [Plugins that I use](#plugins-that-i-use)
    - [Download the plugins](#download-the-plugins)
    - [Oh My zsh themes](#oh-my-zsh-themes)
    - [Custom aliases in ohmyzsh](#custom-aliases-in-ohmyzsh)
  - [Bat](#bat)
  - [Terminator](#terminator)
  - [tldr](#tldr)
  - [bd](#bd)
  - [Flatpak](#flatpak)
    - [Install the Software Flatpak plugin](#install-the-software-flatpak-plugin)
    - [Add the Flathub repository](#add-the-flathub-repository)
  - [Mission Center](#mission-center)
  - [Neofetch](#neofetch)
- [Additional Tools not related to the Kali Installation](#additional-tools-not-related-to-the-kali-installation)
  - [speedtest-cli](#speedtest-cli)
  - [ipmitool](#ipmitool)
  - [keepassxc](#keepassxc)
  - [IPv4Bypass](#ipv4bypass)
  - [D(HE)ater](#dheater)
  - [SNMP](#snmp)
    - [Examples for Cisco devices](#examples-for-cisco-devices)
    - [To install the MIBs](#to-install-the-mibs)
    - [To display the arp table on a Cisco switch](#to-display-the-arp-table-on-a-cisco-switch)
    - [To display a switch serial number](#to-display-a-switch-serial-number)
    - [To display the system information](#to-display-the-system-information)
    - [SNMP References](#snmp-references)

## Initial Installation

Kali install on 2015 MacBook Pro (Model 1502)
This is a simple tutorial on how to install Kali on a 2015 MacBook Pro. I didn't think it would work but it did. Now I will work on an Ansible playbook so that I can wipe and rebuild easily.

I followed the Kali.org website instructions to get Kali installed on the 2015 MacBook Pro (Model 1502). The instructions are available here: [Installing Kali on Mac Hardware](https://www.kali.org/docs/installation/hard-disk-install-on-mac/)

### Creating the bootable flash drive

I downloaded the Installer Images iso file from [Installer Images](https://www.kali.org/get-kali/#kali-platforms).  Select the "recommended 64 bit" image. Use a torrent link to download the iso on Mac/Linux. On Windows use the direct download link. There is a "sum" link on the page. Be sure to use sha256sum on Mac/Linux or certutils on Windows to verify the hash.

Since I was using a Linux laptop I used dd to create the bootable flash drive. On Windows or if you want to use a GUI, I recommend Balena Etcher.

Insert the usb flash drive and enter `lsblk` to find the name of the flash drive. In my case it was sdc.  Enter the following command to create the bootable flash drive.

`dd if=kali-linus-2023.3-installer-amd64.iso of=/dev/sdc bs=10M status=progress && sync`

When the drive is ready the progress flag that we used with dd will show you what was copied. At that point, eject the flash drive and put it into the MacBook Pro.

### Repartioning the hard drive

During the install process, I selected "Guided - Use entire disk" and "separate /home partition". I didn't see a way to change the default partition sizes and I wasn't happy with them.

To resize the partitions, I booted off of a "System Rescue" flash drive and used Gparted to move/resize the partitions. I highly recommend having a bootable "system rescue" flash drive with you anytime that a "Friend" needs help with a PC - windows, Linux, or Mac!

Download the "system rescue" iso [here](https://www.system-rescue.org/Download/)

`dd if=systemrescue-10.02-amd64.iso of=/dev/sdc bs=10M status=progress && sync
`

I used the following partion sizes:

```bash
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0 465.9G  0 disk
├─sda1   8:1    0   512M  0 part /boot/efi
├─sda2   8:2    0  80.7G  0 part /
├─sda3   8:3    0  51.7G  0 part [SWAP]
└─sda4   8:4    0   332G  0 part /home
```

The reason for the large sda2 partition is that I wanted to use "Kali Tweaks" to do a full install of the Kali tools. When it finished the partition was 55% full.

The reason for the 51.7G SWAP partition is that I couldn't get suspend to work and to use hibernation Kali recommends 1.5x of RAM. I have 16GB on this MacBook so I needed a minimum of 24GB but I  figured i'd double it.

## A Couple Guides to help you with Linux

### Ubuntu for Network Engineers

I wrote a guide on using Ubuntu for network engineering. It has more detailed information on each of these tools. If you are new to Linux and the terminal I recommend you grab a copy. There are a lot of hard earned tips in it. You can download it [here](https://github.com/rikosintie/Documents/blob/master/Ubuntu-For-Network-Engineers-05303022.pdf)

### The Hackers Choice
The Hacker's Choice site is great. The IPv6 Attack Tookit is aging now but it's still a great toolkit for IPv6 hacking.

They put statements like this on everything "**We show the tricks 'as is' without any explanation why they work. You need to know Linux to understand how and why they work.**" And "**It's always good to commit suicide when exiting a shell.**"

 `alias exit='kill -9 $$'`

I was really annoyed when I first installed the toolkit but it turned out to be a good idea. I had to do a lot of learning to use the toolkit but I am better for it.

[THC's favourite Tips, Tricks & Hacks (Cheat Sheet)](https://github.com/hackerschoice/thc-tips-tricks-hacks-cheat-sheet#bash-no-history)

Pro-Tip: The THC IPv6 toolkit is installed on Kali with "large" or "Everything" metapackages. But, for some reason, you have to prepend "atk-" to the tools. For example,

```bash
sudo atk6-detect-new-ip6 wlan0
Started ICMP6 DAD detection (Press Control-C to end) ...
```

## Installed software

This is just the initial software that I install on any Debian or Ubuntu disto.
Obviously, the software list will grow over time.

- tlp power management
  - sudo apt install tlp
  - sudo systemctl enable tlp
  - sudo systemctl start tlp

- autojump - A cd command that learns - easily navigate directories from the command line
  - sudo apt install autojump

After the install finishes, you need to edit ~/.zhrc using  `nano ~/.zshrc` and add the following to the end of the file:

```bash
#start autojump - /usr/share/autojump/
. /usr/share/autojump/autojump.sh
```

It will take a while before autojump has a lot of your directories memorized but once it does you will save a lot of time navigating the terminal.

### Oh My ZSH

I highly recommend installing Oh My ZSH. It is a well run project and there are hundreds of themes, plugins and customizations available in it.

Normally you shouldn't copy a shell command from the Internet and paste it into your shell but this is how you install Oh My ZSH.  You can go to the Oh My ZSH github repository and review the install.sh file if you are worried.

 `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

#### Plugins that I use

```bash
- git
- auto-autosuggestions
- zsh-completions
- zsh-syntax-highlighting
- history-substring-search
- colored-man-pages
- aliases
- zsh-docker-aliases
```

Format of plugins in the ~/.zshrc file

```bash
    plugins=(
      git
      zsh-completions
      zsh-autosuggestions
      zsh-syntax-highlighting
      history-substring-search
      colored-man-pages
      aliases
      zsh-docker-aliases
      )
```

#### Download the plugins

```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-
highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/akarzim/zsh-docker-aliases.git  ~/.oh-my-zsh/custom/plugins/zsh-docker-aliases
```

#### Oh My zsh themes

Oh My ZSH offers a lot of themes. I found one that I really like called duellj. To install it change the ZSH-THEME line to:
ZSH_THEME="duellj"

I also like “amuse”. It’s similar to duellj but doesn’t put the username/machine name in the terminal. Since I’m on my personal laptop I don’t need that information. To use “amuse”

`ZSH_THEME="amuse"`

Find more themes here: [zsh themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)

#### Custom aliases in ohmyzsh

I like to keep my own aliases in an ohmyzsh "custom aliases" file. To create this file:

```bash
touch ~/.oh-my-zsh/custom/my-aliases.zsh
gedit ~/.oh-my-zsh/custom/my-aliases.zsh
```

Create all of your custom aliases in this file. Anytime that you add an alias you need to run `exec zsh` to update zsh. I have an alias `sc` that does that. I also use `ec` to open .zshrc.

I preface my aliases with `mw-` which are initals for my first and last name. Then I can type `mw-` and hit tab to see all of my aliases.

```bash
mw-ipen0
mw-bright            mw-dang              mw-ipen8             mw-nmlldp            mw-nmshrun           mw-ports
mw-bright60          mw-extip             mw-kbd               mw-nmshap            mw-nmshstate         mw-running_services
mw-cpu10             mw-ipen0             mw-led               mw-nmshipv4          mw-nmshwifi          mwmail
mw-cpu5              mw-ipen6             mw-nmconnectprof     mw-nmshprofiles      mw-nmwifi
```

That way I don't have to remember all of my aliases.

I found the following code while researching aliases and added it to the custom aliases file. It is so useful, I just type `path` and it lists all my paths in a list instead of all together. You can also include a word and it will grep for it.

```bash
# "path" shows current path, one element per line.
# If an argument is supplied, grep for it.
path() {
    test -n "$1" && {
        echo $PATH | perl -p -e "s/:/\n/g;" | grep -i "$1"
    } || {
        echo $PATH | perl -p -e "s/:/\n/g;"
    }
}
```

Here is the output of the command

```bash
~/04_tools/Kali-mac on  main ⌚ 10:17:59
$ path
/usr/local/sbin
/usr/sbin
/sbin
/usr/local/bin
/usr/bin
/bin
/usr/local/games
/usr/games
/home/bjones/.dotnet/tools

~/04_tools/Kali-mac on  main ⌚ 10:21:47
$ path tools
/home/bjones/.dotnet/tools
```

### Bat

A cat clone with syntax highlighting and Git integration
This is a great upgrade to cat. The automatic paging, syntax highlighting, Git integration and the ability to show non-printable characters makes replacing cat with bat a no brainer.

There are a lot of other features to bat. You should review the official Git repository at
[sharkdp/bat](https://github.com/sharkdp/bat)

Download the latest deb package [here](https://github.com/sharkdp/bat/releases) then install using:
`sudo dpkg -i bat-musl_0.24.0_amd64.deb # adapt version number and architecture`

If you want to use an alias so that cat calls bat, add
`alias cat="bat"`

to ~/.oh-my-zsh/custom/my-aliases.zsh

### Terminator

I like [terminator](https://github.com/gnome-terminator/terminator) as as my terminal emulator. It supports plugins like `logger`, `watch for activity` and tabs. There many emulators for Linux, you may want to Google "Linux Terminal Emulators" yourself and try a different one.

Terminator was first released in 2007. It then transferred to a different team and is now (2023) back under active development on github. The documentation is very helpful and can be found [here](https://gnome-terminator.readthedocs.io/en/latest/gettingstarted.html#context-menu)

- `sudo apt install terminator -y`
- `sudo update-alternatives --config x-terminal-emulator`

### tldr

Too Long, Didn't Read is like a man page but short and to the point.
- `sudo apt install tldr`

### bd

Quickly go back to a specific parent directory in bash instead of typing "cd ../../.." redundantly.
- `sudo apt install bd`
- Create an alias for bd in the ~/.oh-my-zsh/custom/my-aliases.zsh file `alias bd="bd -si"` .
- Reference - [bd on github](https://github.com/vigneshwaranr/bd)

### Flatpak

Flatpak is a universal installer for Linux. It is similar to Snap on Ubuntu.

`apt install flatpak`

#### Install the Software Flatpak plugin

`apt install gnome-software-plugin-flatpak`

#### Add the Flathub repository

Flathub is the best place to get Flatpak apps. To enable it, run:
`flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`

Unfortunately, a reboot is required to activate Flatpak.

Once the system restarts you can go to [flathub](https://flathub.org/) - The Linux App Store and look for applications to install.

### Mission Center

Mission Center is the tool I wanted from Flatpak. It's modeled after the Windows Task manager and has a clean look to it.

<p align="center" width="100%">
    <img width="50%" src="https://github.com/rikosintie/Kali-mac/blob/main/images/Mission-Center.png">
</p>

### Neofetch

Neofetch is a tool that dumps out system information. It's short and sweet but useful.

```bash
$ neofetch
..............                                     bjones@Dell-G5-5587
            ..,;:ccc,.                             -------------------
          ......''';lxO.                           OS: Kali GNU/Linux Rolling x86_64
.....''''..........,:ld;                           Host: MacBookPro12,1 1.0
           .';;;:::;,,.x,                          Kernel: 6.5.0-kali3-amd64
      ..'''.            0Xxoc:,.  ...              Uptime: 13 hours, 50 mins
  ....                ,ONkc;,;cokOdc',.            Packages: 4618 (dpkg), 9 (flatpak)
 .                   OMo           ':ddo.          Shell: zsh 5.9
                    dMc               :OO;         Resolution: 2560x1600
                    0M.                 .:o.       DE: GNOME 45.0
                    ;Wd                            WM: Mutter
                     ;XO,                          WM Theme: Kali-Dark
                       ,d0Odlc;,..                 Theme: adw-gtk3-dark [GTK2/3]
                           ..',;:cdOOd::,.         Icons: Flat-Remix-Blue-Dark [GTK2/3]
                                    .:d;.':;.      Terminal: terminator
                                       'd,  .'     CPU: Intel i5-5287U (4) @ 3.300GHz
                                         ;l   ..   GPU: Intel Iris Graphics 6100
                                          .o       Memory: 7080MiB / 15893MiB
                                            c
                                            .'
                                             .

```

## Additional Tools not related to the Kali Installation

### speedtest-cli

Speedtest without the browser
  - `sudo apt install speedtest-cli`

### ipmitool

A tool for working with ipmi software like Dell iDrac and HP ilo

- `sudo apt-get install ipmitool`

### keepassxc

A great, well maintained, open source password manager.

`sudo apt install keepassxc`

### IPv4Bypass

Using IPv6 to Bypass Security Policy
[IPv4Bypass](https://github.com/milo2012/ipv4Bypass/tree/master)

Clone the repository
`git clone https://github.com/milo2012/ipv4Bypass.git`

Change to the ipv4Bypass directory and execute the script.
`sudo python bypass.py -i wlan0 -r 192.168.10.0/24`

### D(HE)ater

[D(HE)ater](https://github.com/c0r0n3r/dheater)  is an attacking tool based on CPU heating in that it forces the ephemeral variant of Diffie-Hellman key exchange (DHE) in given cryptography protocols (e.g. TLS, SSH).

D(HE)ater can be installed directly via pip from PyPi

```bash pip install dheater
dheat --protocol tls ecc256.badssl.com
dheat --protocol ssh ecc256.badssl.com
```

or can be used via Docker from Docker Hub

```bash docker pull balasys/dheater
docker run --tty --rm balasys/dheater --protocol tls ecc256.badssl.com
docker run --tty --rm balasys/dheater --protocol ssh ecc256.badssl.com
```

### SNMP

An oldie but goodie! SNMP is a valuable tool for a network engineer or pentester. It's surprising how many devices are deployed with a community string of "public". Using SNMP you can retrieve a lot of information about the devices.

- `sudo apt install snmp`

Due to license issues the MIBs disabled by default. To enable them simply comment out the
MIBS line in /etc/snmp/snmp.conf

`sudo gedit /etc/snmp/snmp.conf`

```bash
# As the snmp packages come without MIB files due to license reasons, loading
# of MIBs is disabled by default. If you added the MIBs you can reenable
# loading them by commenting out the following line.
mibs :
```

Put a `#` in front of "mibs", save and exit

#### Examples for Cisco devices

NOTE: A lot has changed since 2015 when I first wrote this in the Ubuntu for Nework Engineers guide. Cisco now has separate mib files for EVERY device.  This page explains how things have changed: [SNMP FAQ](https://www.cisco.com/c/en/us/support/docs/ip/simple-network-management-protocol-snmp/9226-mibs-9226.html)

You can still get the v2 mibs from Cisco's [mib site](https://cisco.github.io/cisco-mibs/v2/v2.tar.gz). I haven't tested against anything but an IOS based switch (2960s) so you'll need to do some testing against newer devices.

As always, preparation is the key to success!

#### To install the MIBs

Make a new directory for the Cisco MIBs
`sudo mkdir /usr/share/snmp/mibs/cisco`

copy v2.tar.gz that you just downloaded to /usr/share/snmp/mibs/cisco
`sudo cp v2.tar.gz /usr/share/snmp/mibs/cisco/v2.tar.gz`

untar to the MIBs

`sudo tar xvfz  /usr/share/snmp/mibs/cisco/v2.tar.gz --directory=/usr/share/snmp/mibs/cisco/`

Verify that the mibs are installed correctly
`sudo ls -l  /usr/share/snmp/mibs/cisco/auto/mibs/v2`

Edit snmp.conf
`sudo gedit /etc/snmp/snmp.conf`

add this at the end of the file:
mibdirs +/usr/share/snmp/mibs/cisco/auto/mibs/v2

#### To display the arp table on a Cisco switch

```bash
snmpbulkwalk -v 2c -c Sup3rS3cr3t -OXsq 10.243.1.1 \.1.3.6.1.2.1.3.1.1.2
iso.3.6.1.2.1.3.1.1.2.82.1.10.243.1.1 "00 2A 10 77 8B 80 "
iso.3.6.1.2.1.3.1.1.2.94.1.192.168.1.1 "00 2A 10 77 8B 80 "
iso.3.6.1.2.1.3.1.1.2.96.1.10.243.2.1 "00 2A 10 77 8B 80 "
iso.3.6.1.2.1.3.1.1.2.96.1.10.243.2.2 "38 0E 4D F9 82 F0 "
iso.3.6.1.2.1.3.1.1.2.96.1.10.243.2.3 "38 0E 4D 6F 94 9C "
iso.3.6.1.2.1.3.1.1.2.96.1.10.243.2.4 "6C B2 AE 09 F8 C4 "
iso.3.6.1.2.1.3.1.1.2.96.1.10.243.2.5 "7C AD 74 50 10 42 "
iso.3.6.1.2.1.3.1.1.2.96.1.10.243.2.6 "38 0E 4D F9 86 8C "
iso.3.6.1.2.1.3.1.1.2.96.1.10.243.2.7 "6C B2 AE 09 F5 48 "
```

#### To display a switch serial number

`snmpget -v 2c -c Sup3rS3cr3t -O s 10.207.1.26 .1.3.6.1.2.1.47.1.1.1.1.11.1001`

iso.3.6.1.2.1.47.1.1.1.1.11.1001 = STRING: "FDO1320X0XP"

#### To display the system information

`snmpbulkwalk -v2c -Os -c Sup3rS3cr3t 10.243.1.1 system`

```bash
sysDescr.0 = STRING: Cisco IOS Software, c6880x Software (c6880x-ADVENTERPRISEK9-M),
Version 15.2(1)SY7, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2018 by Cisco Systems, Inc.
Compiled Thu 05-Jul-18 04:32 by prod_rel_team
sysObjectID.0 = OID: enterprises.9.1.1934
sysUpTimeInstance = Timeticks: (416930035) 48 days, 6:08:20.35
sysContact.0 = STRING:
sysName.0 = STRING: TEST-6880x.home.local
sysLocation.0 = STRING: <Home Lab>
sysServices.0 = INTEGER: 78
sysORLastChange.0 = Timeticks: (0) 0:00:00.00
```

If the "system" name fails with
 `system: Unknown Object Identifier (Sub-id not found: (top) -> system)`

Try
`snmpbulkwalk -v2c -Os -c Sup3rS3cr3t 10.243.1.1 1.3.6.1.2.1.1
`

#### SNMP References

SNMP is a great tool to have in your toolbox. It is NOT easy to use and will require you to build a lab and learn a lot about an anient technology. However, it wil pay off in pentesting and network refreshes.

- [Brute Forcing SNMP with NMAP](https://mwhubbard.blogspot.com/2015/03/brute-forcing-snmp-with-nmap.html)
- [Ubuntu MIBS downloader](https://launchpad.net/ubuntu/xenial/amd64/snmp-mibs-downloader/1.1)
- [Online MIB Browser](https://mibbrowser.online/mibdb_search.php)
- [Using SNMP to retrieve the ARP and mac-address tables from a switch](https://networkengineering.stackexchange.com/questions/2990/translating-snmpwalk-output-into-human-readable-format/775/)
- [Cisco MIB Locator](https://mibs.cloudapps.cisco.com/ITDIT/MIBS/MainServlet)
- [Did not find 'zeroDotZero' in module SNMPv2-SMI](https://serverfault.com/questions/440319/did-not-find-zerodotzero-in-module-snmpv2-smi)
- [snmpwalk Unknown Object Identifier](https://serverfault.com/questions/815535/snmpwalk-unknown-object-identifier)
