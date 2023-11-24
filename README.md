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
  - [iPerf3 Docker image](#iperf3-docker-image)
  - [iPerf3 local installation](#iperf3-local-installation)
  - [To use iPerf3 as a client](#to-use-iperf3-as-a-client)
  - [speedtest-cli](#speedtest-cli)
  - [ipmitool](#ipmitool)
  - [keepassxc](#keepassxc)
  - [IPv4Bypass](#ipv4bypass)
  - [D(HE)ater](#dheater)
  - [Ubiquiti Discovery Protocol](#ubiquiti-discovery-protocol)
  - [SNMP](#snmp)
    - [My blog posts on snmp hacking](#my-blog-posts-on-snmp-hacking)
    - [Installing snmp](#installing-snmp)
    - [snmpcheck](#snmpcheck)
    - [onesixtyone](#onesixtyone)
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

### iPerf3 Docker image

iPerf3 is a udp/tcp bandwidth quality/measurement tool. iPerf3 is principally developed by ESnet/Lawrence Berkeley National Laboratory. It is released under a three-clause BSD license. It is a great tool for diagnosing bandwidth issues. It can be used to test Access Points, Ethernet links, VPN, WAN links, almost anything.

Intel has a Docker image for iPerf3. It can be used as a sever or client.

The image is available on docker hub at [clearlinux/iperf](https://hub.docker.com/r/clearlinux/iperf)

Note: If you don't have a Docker account I recommend creating one. It's free and you will need it to do any Cisco/Juniper/Aruba NetDevOps work.

The easiest way to get started with this image is by simply pulling it from Docker Hub.

- Pull the image from Docker Hub:

  - `docker pull clearlinux/iperf`

- Start a container using the examples below:

**Run as Server:**

- `sudo docker run -it --rm --name=iperf-srv -p 5201:5201 clearlinux/iperf -s`

I created aliases in the ~/.oh-my-zsh/zsh-aliases.zsh file for the server and client versions:

\# start docker iperf3 server on port 5201

- `alias mw-iperf3='sudo docker run -it --rm --name=iperf-srv -p 5201:5201 clearlinux/iperf -s'`

\# start docker iperf3 client on port 5201, omit 2 seconds, run for  5 seconds, 4 streams

- `alias mw-iperf3c='sudo docker run -it --rm clearlinux/iperf -c 192.168.10.181 -p 5200 -O 2 -t 5 -P 4 $1'`

Note: the "$1" after the -c means pass the terminal option to the alias. That allows you to enter the
ip address of the server.

For example:

- `mw-iperf3c 192.168.10.181`

### iPerf3 local installation

Even though the docker works fine, I like to have a local version of iPerf. There are no compiled binaries available on the esnet site for iPerf3. We will download the tar file and then build the binary.

This used to be a daily task on Linux but now it's somewhat rare to have to build your own binary because of Snaps, Appimages and Flatpaks. Keep in mind that this local version will not be updated automatically. You will have to rebuild.

Download the tarball from [downloads](https://downloads.es.net/pub/iperf/)  - As of November, 2023 this is the latest tarball

`iperf-3-current.tar.gz   14-Sep-2023 18:40       649330`

Unpack the file, cd to the iperf directory, and run the build tools.

```bash
tar xvzf iperf-3-current.tar.gz
cd iperf-3.15
./configure
sudo make
sudo make install
ldconfig
iperf3 --help
```

### To use iPerf3 as a client

**In this exmample:**

``` text
-c - client mode
-O 2 - Ignore the first 2 seconds. I find that on wireless this is a good option to use.
-P 5 - Use 5 parallel streams. I have done a lot of AP testing and 4-5 streams seems to work best.
-t 5 - Run the test for 5 seconds. The default is 10
-T iPerf-test - Name of the run. If you are testing a lot of APs, you should name each run and then you have a good log. You can use Excel to create the command with the AP name embedded in the command.
```

```bash
iperf3 -c 192.168.10.181 -O 2 -P 5 -T iPerf-Test
iPerf-Test:  Connecting to host 192.168.10.181, port 5201
iPerf-Test:  [  5] local 192.168.10.154 port 43050 connected to 192.168.10.181 port 5201
iPerf-Test:  [  7] local 192.168.10.154 port 43062 connected to 192.168.10.181 port 5201
iPerf-Test:  [  9] local 192.168.10.154 port 43066 connected to 192.168.10.181 port 5201
iPerf-Test:  [ 11] local 192.168.10.154 port 43068 connected to 192.168.10.181 port 5201
iPerf-Test:  [ 13] local 192.168.10.154 port 43082 connected to 192.168.10.181 port 5201
iPerf-Test:  [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
iPerf-Test:  [  5]   0.00-1.00   sec  6.79 MBytes  56.9 Mbits/sec    0    320 KBytes       (omitted)
iPerf-Test:  [  7]   0.00-1.00   sec  6.17 MBytes  51.7 Mbits/sec    0    279 KBytes       (omitted)
iPerf-Test:  [  9]   0.00-1.00   sec  5.82 MBytes  48.8 Mbits/sec    0    270 KBytes       (omitted)
iPerf-Test:  [ 11]   0.00-1.00   sec  6.25 MBytes  52.4 Mbits/sec    0    296 KBytes       (omitted)
iPerf-Test:  [ 13]   0.00-1.00   sec  6.38 MBytes  53.5 Mbits/sec    0    293 KBytes       (omitted)
iPerf-Test:  [SUM]   0.00-1.00   sec  31.4 MBytes   263 Mbits/sec    0             (omitted)
iPerf-Test:  - - - - - - - - - - - - - - - - - - - - - - - - -
iPerf-Test:  [  5]   1.00-2.00   sec  8.46 MBytes  71.0 Mbits/sec    0    643 KBytes       (omitted)
iPerf-Test:  [  7]   1.00-2.00   sec  6.77 MBytes  56.8 Mbits/sec    0    571 KBytes       (omitted)
iPerf-Test:  [  9]   1.00-2.00   sec  6.52 MBytes  54.7 Mbits/sec    0    540 KBytes       (omitted)
iPerf-Test:  [ 11]   1.00-2.00   sec  8.20 MBytes  68.8 Mbits/sec    0    607 KBytes       (omitted)
iPerf-Test:  [ 13]   1.00-2.00   sec  6.87 MBytes  57.6 Mbits/sec    0    598 KBytes       (omitted)
iPerf-Test:  [SUM]   1.00-2.00   sec  36.8 MBytes   309 Mbits/sec    0             (omitted)
iPerf-Test:  - - - - - - - - - - - - - - - - - - - - - - - - -
iPerf-Test:  [  5]   0.00-1.00   sec  6.25 MBytes  52.4 Mbits/sec    0    946 KBytes
iPerf-Test:  [  7]   0.00-1.00   sec  7.31 MBytes  61.3 Mbits/sec    0    863 KBytes
iPerf-Test:  [  9]   0.00-1.00   sec  7.28 MBytes  61.1 Mbits/sec    0    819 KBytes
iPerf-Test:  [ 11]   0.00-1.00   sec  6.17 MBytes  51.8 Mbits/sec    0    892 KBytes
iPerf-Test:  [ 13]   0.00-1.00   sec  7.38 MBytes  61.9 Mbits/sec    0    856 KBytes
iPerf-Test:  [SUM]   0.00-1.00   sec  34.4 MBytes   288 Mbits/sec    0
iPerf-Test:  - - - - - - - - - - - - - - - - - - - - - - - - -

```

I have written some blogs on iperf3:

- [Using iPerf3 to verify Link Quality](https://mwhubbard.blogspot.com/2014/12/using-iperf3-to-verify-link-quality.html)
- [Using iPerf3 to Test 2.5Gb/5Gb and 10Gb Links](https://mwhubbard.blogspot.com/2018/08/using-iperf3-to-test-25gb5gb-and-10gb.html)
- [Update to testing 10Gb links with iPerf3](https://mwhubbard.blogspot.com/2018/09/update-to-testing-10gb-links-with-iperf3.html)

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

### Ubiquiti Discovery Protocol

 Ubiquiti devices use UDP on port 10001 for autodiscover of other Ubiquiti devices.

To look at what the discover sends out, you can use the following commands. No authentication is required to get the output. As with all network devices, you should use a dedicated management vlan and ACL it off so that only authorized stations can access the management interface.

This is from a NanoStation 5 AC loco in my lab. It has the following settings:

```bash
SSID - death2all
firmware version - WA.v8.5.11.39842.190109.1449.bin
Device name - Office
```

```bash

echo -ne "\x01\x00\x00\x00" | socat -t 1 udp:192.168.10.50:10001 - | hexdump -C
00000000  01 00 00 9e 01 00 06 fc  ec da c4 6e 55 02 00 0a  |...........nU...|
00000010  fc ec da c4 6e 55 c0 a8  0a 32 02 00 0a fc ec da  |....nU...2......|
00000020  c4 6e 55 a9 fe 6e 55 03  00 22 57 41 2e 61 72 39  |.nU..nU.."WA.ar9|
00000030  33 34 78 2e 76 38 2e 37  2e 31 2e 34 32 38 33 32  |34x.v8.7.1.42832|
00000040  2e 32 30 30 36 32 33 2e  31 36 34 31 0a 00 04 05  |.200623.1641....|
00000050  a3 c9 d8 0b 00 06 4f 66  66 69 63 65 0c 00 07 4c  |......Office...L|
00000060  6f 63 6f 35 41 43 0d 00  09 64 65 61 74 68 32 61  |oco5AC...death2a|
00000070  6c 6c 0e 00 01 03 10 00  02 e7 fa 13 00 06 fc ec  |ll..............|
00000080  da c4 6e 55 14 00 14 4e  61 6e 6f 53 74 61 74 69  |..nU...NanoStati|
00000090  6f 6e 20 35 41 43 20 6c  6f 63 6f 18 00 04 00 00  |on 5AC loco.....|
000000a0  00 00                                             |..|
000000a2

```

Nmap
There is an Nmap script for Ubiquiti Discovery - ubiquiti-discovery.nse. It pulls down more information than the bash script and will work on Windows. The home page for the script is [here](https://nmap.org/nsedoc/scripts/ubiquiti-discovery.html).

`sudo nmap -sU -p 10001 --script ubiquiti-discovery.nse -oG ubnt 192.168.10.50`

```bash
-p - port default is 10001
-oG ubnt - save output in "grepable format"
```
Here is the script output

```bash
sudo nmap -sU -p 10001 --script ubiquiti-discovery.nse -oG ubnt 192.168.10.50
[sudo] password for bjones:
Starting Nmap 7.94SVN ( https://nmap.org ) at 2023-11-23 19:46 PST
Nmap scan report for 192.168.10.50
Host is up (0.0019s latency).

PORT      STATE SERVICE
10001/udp open  ubiquiti-discovery
| ubiquiti-discovery:
|   protocol: v1
|   firmware: WA.ar934x.v8.7.1.42832.200623.1641
|   version: v8.7.1
|   uptime_seconds: 94641897
|   uptime: 1095 days 09:24:57
|   hostname: Office
|   product: Loco5AC
|   essid: death2all
|   model: NanoStation 5AC loco
|   interface_to_ip:
|     fc:ec:da:c4:6e:55:
|       192.168.10.50
|       169.254.110.85
|   mac_addresses:
|_    fc:ec:da:c4:6e:55
MAC Address: FC:EC:DA:C4:6E:55 (Ubiquiti Networks)
Service Info: OS: Linux

Nmap done: 1 IP address (1 host up) scanned in 0.37 seconds

```

Here is a blog I wrote about the Ubiquiti discovery protocol with more details. If you have a lot of Ubiqiti radios, the blog has a shell script that will scan a batch of IPs and report the firmware version.

[Ubiquiti Discovery Protocol - Find the firmware version-SSID-Model](https://mwhubbard.blogspot.com/2019/02/ubiquiti-discovery-protocol-find.html)

### SNMP

An oldie but goodie! SNMP is a valuable tool for a network engineer or pentester. It's surprising how many devices are deployed with a community string of "public". Using SNMP you can retrieve a lot of information about the devices.

This is a good video on snmp enumeration in [Kali](https://www.youtube.com/watch?v=zYqSOcbVZ4k). The built in tools are good and I will show how to install vendor specific MIBs to extend your scanning.

I have a python script that that wraps several nmap scripts for ease of use. You can grab it [here](https://github.com/rikosintie/nmap-python). See script 14 for snmp.

#### My blog posts on snmp hacking

- [How to Download an IOS configuration with NMAP's snmp-ios-config Script](https://mwhubbard.blogspot.com/2015/03/how-to-download-ios-configuration-with.html)
- [Brute Forcing SNMP with NMAP](https://mwhubbard.blogspot.com/2015/03/brute-forcing-snmp-with-nmap.html)

Pro-tip:
Use `site:mwhubbard.blogspot.com snmp` in a browser to search for snmp blogs on my site.

#### Installing snmp

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

#### snmpcheck

This tool is built into kali. Here is an example against a Cisco 2960s

```bash
snmp-check 192.168.10.15 -c public
snmp-check v1.9 - SNMP enumerator
Copyright (c) 2005-2015 by Matteo Cantoni (www.nothink.org)

[+] Try to connect to 192.168.10.15:161 using SNMPv1 and community 'public'

[*] System information:

  Host IP address               : 192.168.10.15
  Hostname                      : Switch.pu.pri
  Description                   : Cisco IOS Software, C2960S Software (C2960S-UNIVERSALK9-M), Version 15.2(2)E9, RELEASE SOFTWARE (fc4)  Technical Support: http://www.cisco.com/techsupport  Copyright (c) 1986-2018 by Cisco Systems, Inc.  Compiled Sat 08-Sep-18 14:56 by prod_rel_team
  Contact                       : bjones@gmail.com
  Location                      : Rack2-U30
  Uptime snmp                   : -
  Uptime system                 : 00:55:56.67
  System date                   : -
  ... Truncated interfaces for brevity
  [*] Network IP:

  Id                    IP Address            Netmask               Broadcast
  10                    192.168.10.15         255.255.255.0         1

[*] TCP connections and listening ports:

  Local address         Local port            Remote address        Remote port           State
  192.168.10.15         22                    192.168.10.154        42148                 established

[*] Listening UDP ports:

  Local address         Local port
  192.168.10.15         161
  192.168.10.15         162
  192.168.10.15         2228
  192.168.10.15         10002
  192.168.10.15         53617
```

#### onesixtyone

This tool allows you to use a dictionary of community strings and a file for hosts.

```bash
examples: onesixtyone 192.168.4.0/24 public
          onesixtyone -c dict.txt -i hosts -o my.log -w 100

```

A scan on my home lab with a Cisco 2960, a Windows DC and an HP 8600 printer

```bash
onesixtyone 192.168.10.0/24 public
Scanning 256 hosts, 1 communities
192.168.10.15 [public] Cisco IOS Software, C2960S Software (C2960S-UNIVERSALK9-M), Version 15.2(2)E9, RELEASE SOFTWARE (fc4)  Technical Support: http://www.cisco.com/techsupport  Copyright (c) 1986-2018 by Cisco Systems, Inc.  Compiled Sat 08-Sep-18 14:56 by prod_rel_team
192.168.10.221 [public] Hardware: Intel64 Family 6 Model 69 Stepping 1 AT/AT COMPATIBLE - Software: Windows Version 6.1 (Build 7601 Multiprocessor Free)
192.168.10.239 [public] HP ETHERNET MULTI-ENVIRONMENT
Error in sendto: Permission denied
```

### Examples for Cisco devices

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
