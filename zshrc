# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mhubbard/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="duellj"
ZSH_THEME="amuse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git 
    zsh-completions 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    history-substring-search 
    autojump 
    aliases 
    colored-man-pages 
    thefuck
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='gedit'
 else
   export EDITOR='subl'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias python=python3
alias pip=pip3
# Return the public IP address your are using
alias mw-extip="dig +short myip.opendns.com @resolver1.opendns.com"
# return IP info for wlp61s0
alias mw-ipen0='ip addr show wlp61s0 | grep "link\|inet";ip route | grep default | grep wlp0s20f3;nmcli dev show wlp0s20f3 | grep DNS | grep IP4'
# return IP info for enp60s0
alias mw-ipen6='ip addr show enp60s0 | grep "link\|inet";ip route | grep default | grep enp60s0;nmcli dev show enp60s0 | grep DNS | grep IP4'
# return IP info for enp8s0
alias mw-ipen8='ip addr show enp8s0 | grep "link\|inet";ip route | grep default | grep enp60s0;nmcli dev show enp60s0 | grep DNS | grep IP4;ip addr show enp60s0 | grep inet6'

#show status of network manager
alias mw-nmshrun="nmcli -t -f RUNNING general"

#show network manager state
alias mw-nmshstate="nmcli -t -f STATE general"

#show network connection profiles $1 is interface name
alias mw-nmshprofiles='(){nmcli -a -f CONNECTIONS device show $1}'

#connect to an existing profile
alias mw-nmconnectprof='(){nmcli -p connection up "$1" ifname eth0}'

#show profile IPv4 settings. Profile must be active. $1 is profile name I.E. "Wired connection 1"
alias mw-nmshipv4='(){nmcli -a -f IP4 connection show $1}'

#Show wifi properties
alias mw-nmwifi='nmcli -f GENERAL,WIFI-PROPERTIES dev show wlan0'

#lists available Wi-Fi access points known to NetworkManager
alias mw-nmshap='nmcli dev wifi'

#Use mw-nmcli to list lldp neighbors
alias mw-nmlldp='(){sudo nmcli -a -p device lldp list ifname $1}'

#show wifi passwords
alias mw-nmshwifi='(){sudo nmcli -a -p device wifi show-password ifname $1}'

#list running systemd services
alias mw-running_services='systemctl list-units --type=service --state=running'

# open ~/.zshrc in using the default editor specified in $EDITOR
alias ec="$EDITOR $HOME/.zshrc"
# rerun ~/.zshrc after making changes
alias sc="exec zsh"
#run bat instead of cat
alias cat="bat"
#add sudo and repeat the last command
alias mw-dang='sudo $(fc -ln -1)'
alias mw-ports='netstat -tulanp'
#-p no error if existing, make parent directories as needed -v print a message for each created directory
alias mkdir='mkdir -pv'
#hide snap file system
alias df="df -h --exclude=squashfs"
#-c like verbose but report only when a change is made
alias chmod="chmod -c"
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias back='cd $OLDPWD'
# bd jumps backward in paths https://github.com/vigneshwaranr/bd
alias bd='. bd -si'
#-i prompt before overwrite -v verbse
alias cp='cp -iv'
alias mv='mv -iv'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias l.='ls -lhFa --time-style=long-iso --color=auto'
alias ls='ls -lhF --time-style=long-iso --color=auto'
alias exa1='exa -lFT --group-directories-first'
alias mw-bright60='xrandr --output eDP-1 --brightness 0.60'
# to set a different brightness use bright .9 
alias mw-bright='xrandr --output eDP-1 --brightness $1'
alias mw-kbd='sudo brightnessctl --device='dell::kbd_backlight' set $1'
alias mw-led='sudo brightnessctl --device='intel_backlight' set $1'
#function bright () {
#    xrandr --output eDP-1 --brightness $1
#}
## get top process eating memory
alias mem5='ps auxf | sort -nr -k 4 | head -5'
alias mem10='ps auxf | sort -nr -k 4 | head -10'
 
## get top process eating cpu ##
alias mw-cpu5='ps auxf | sort -nr -k 3 | head -5'
alias mw-cpu10='ps auxf | sort -nr -k 3 | head -10'
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Prevent duplicates in history
setopt hist_ignore_all_dups hist_save_nodups

# "path" shows current path, one element per line.
# If an argument is supplied, grep for it.
path() {
    test -n "$1" && {
        echo $PATH | perl -p -e "s/:/\n/g;" | grep -i "$1"
    } || {
        echo $PATH | perl -p -e "s/:/\n/g;"
    }
}
