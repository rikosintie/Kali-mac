# Kali-mac
Kali install on 2015 MacBook 1502

## Installed software
* tlp power management
    - sudo apt install tlp
    - sudo systemctl enable tlp
    - sudo systemctl start tlp
* autojump - A cd command that learns - easily navigate directories from the command line
  - sudo apt install autojump

After the install finishes you need to edit `~/.bashrc (nano ~/.bashrc)` and add the following to the end of the
file:
```
#start autojump - /usr/share/autojump/
. /usr/share/autojump/autojump.sh
```

It will take a while before autojump has a lot of your directories memorized but once it does you will save a lot
of time navigating the terminal.

* Oh My ZSH
  - sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  - Plugins
      - git
      - auto-autosuggestions
      - zsh-completions
      - zsh-syntax-highlighting
      - history-substring-search
      - colored-man-pages
      - aliases
      - zsh-docker-aliases
   
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
```
### Oh My zsh themes
Oh My ZSH offers a lot of themes. I found one that I really like called duellj. To install it change the ZSH-
THEME line to:  
ZSH_THEME="duellj"  

I also like “amuse”. It’s similar to duellj but doesn’t put the username/machine name in the terminal. Since I’m
on my personal laptop I don’t need that information. To use “amuse”  

`ZSH_THEME="amuse"`

Find more themes here: [zsh themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)

* Bat - A cat clone with syntax highlighting and Git integration
This is a great upgrade to cat. The automatic paging, syntax highlighting, Git integration and the ability to show
non-printable characters makes replacing cat with bat a no brainer.
There are a lot of other features to bat. You should review the official Git repository at
https://github.com/sharkdp/bat

`sudo dpkg -i bat-musl_0.24.0_amd64.deb # adapt version number and architecture`

If you want to use an alias so cat calls bat, add  
`alias cat='bat'`

to ~/.zshrc

- Terminator as the terminal emulator
  - `sudo apt install terminator -y`
  - `sudo update-alternatives --config x-terminal-emulator`
 
- tldr - Too Long, Didn't Read is like a man page but short and to the point.
  - `sudo apt install tldr`
 
- bd - Quickly go back to a specific parent directory in bash instead of typing "cd ../../.." redundantly.
  - `sudo apt install bd'
  - Reference - [bd on github](https://github.com/vigneshwaranr/bd)  
