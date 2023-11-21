# bd jumps backward in paths https://github.com/vigneshwaranr/bd
alias bd='. bd -si'

# run bat instead of cat
alias cat="bat"

# gnome-screenshot from terminal
alias gsw='gnome-screenshot -w'
alias gsa='gnome-screenshot -a'
 
alias python=python3
alias pip=pip3

# start docker iperf3 server on port 5201
alias mw-iperf3='sudo docker run -it --rm --name=iperf-srv -p 5201:5201 clearlinux/iperf -s'

# start docker iperf3 client on port 5201
alias mw-iperf3c='sudo docker run -it --rm --network=host -p 5201 clearlinux/iperf -c $1'

# Return the public IP address your are using
alias mw-extip="dig +short myip.opendns.com @resolver1.opendns.com"

# return IP info for wlan0
alias mw-ipen0='ip addr show wlan0 | grep "link\|inet";ip route | grep default | grep wlp0s20f3;nmcli dev show wlan0 | grep DNS | grep IP4'

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
alias ec='$EDITOR $HOME/.zshrc'

# open ~/.oh-my-zsh/custom/my-aliases.zsh
alias ec1='$EDITOR ~/.oh-my-zsh/custom/my-aliases.zsh'

# rerun ~/.zshrc after making changes
alias sc='exec zsh'

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
