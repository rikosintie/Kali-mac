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

