# Kali-mac

Kali install on 2015 MacBook Pro (Model 1502)

## Initial Installation

I followed the Kali.org website instructions to get Kali installed on the 2015 MacBook Pro (Model 1502). The instructions are available here: [Installing Kali on Mac Hardware](https://www.kali.org/docs/installation/hard-disk-install-on-mac/)

### Creating the bootable flash drive

I downloaded the Installer Images iso file from [Installer Images](https://www.kali.org/get-kali/#kali-platforms).  Select the "recommended 64 bit" image. Use a torrent if you are on a real OS. On Windows use the direct download link.  

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

```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0 465.9G  0 disk 
├─sda1   8:1    0   512M  0 part /boot/efi
├─sda2   8:2    0  80.7G  0 part /
├─sda3   8:3    0  51.7G  0 part [SWAP]
└─sda4   8:4    0   332G  0 part /home
```

The reason for the large sda2 partition is that I wanted to use "Kali Tweaks" to do a full install of the Kali tools. When it finished the partition was 55% full. 

The reason for the 51.7G SWAP partition is that I couldn't get suspend to work and to use hibernation Kali recommends 1.5x of RAM. I have 16GB on this MacBook so I needed a minimum of 48GB.  

## Installed software  
This is just the initial software that I install on any Debian or Ubuntu disto. 
Obviously, the software list will grow over time.

* tlp power management
  * sudo apt install tlp
  * sudo systemctl enable tlp
  * sudo systemctl start tlp
* autojump - A cd command that learns - easily navigate directories from the command line
  * sudo apt install autojump

After the install finishes you need to edit `~/.zhrc (nano ~/.zshrc)` and add the following to the end of the
file:

```
#start autojump - /usr/share/autojump/
. /usr/share/autojump/autojump.sh
```
It will take a while before autojump has a lot of your directories memorized but once it does you will save a lot of time navigating the terminal.

* Oh My ZSH
  * sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  * Plugins
      * git
      * auto-autosuggestions
      * zsh-completions
      * zsh-syntax-highlighting
      * history-substring-search
      * colored-man-pages
      * aliases
      * zsh-docker-aliases
   
    Format of plugins in the ~/.zshrc file
```
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

Download the plug ins (Autojump should already be installed if you have been following the book. If not
follow the instructions in the previous section to install autojump.

```
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-
highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/akarzim/zsh-docker-aliases.git  ~/.oh-my-zsh/custom/plugins/zsh-docker-aliases
```

### Oh My zsh themes

Oh My ZSH offers a lot of themes. I found one that I really like called duellj. To install it change the ZSH-THEME line to:  
ZSH_THEME="duellj"  

I also like “amuse”. It’s similar to duellj but doesn’t put the username/machine name in the terminal. Since I’m on my personal laptop I don’t need that information. To use “amuse”  

`ZSH_THEME="amuse"`

Find more themes here: [zsh themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)

* Bat - A cat clone with syntax highlighting and Git integration
This is a great upgrade to cat. The automatic paging, syntax highlighting, Git integration and the ability to show non-printable characters makes replacing cat with bat a no brainer.
There are a lot of other features to bat. You should review the official Git repository at
[sharkdp/bat](https://github.com/sharkdp/bat)

`sudo dpkg -i bat-musl_0.24.0_amd64.deb # adapt version number and architecture`

If you want to use an alias so cat calls bat, add  
`alias cat='bat'`

to ~/.zshrc

* Terminator as the terminal emulator
  * `sudo apt install terminator -y`
  * `sudo update-alternatives --config x-terminal-emulator`
 
* tldr - Too Long, Didn't Read is like a man page but short and to the point.
  * `sudo apt install tldr`
 
* bd - Quickly go back to a specific parent directory in bash instead of typing "cd ../../.." redundantly.
  * `sudo apt install bd'
  * Reference - [bd on github](https://github.com/vigneshwaranr/bd)  

* speedtest-cli - Speedtest without the browser
  * `sudo apt install speedtest-cli`
 
* ipmitool - A tool work working with ipmi software like Dell iDrac and HP ilo
  * `sudo apt-get install ipmitool`
 
* SNMP - An oldie but goodie! SNMP is a valuable tool for a network engineer.
  * `sudo apt install snmp`
