alias reload='exec zsh'
alias ls='ls --color=auto'
alias la='ls -lah'
alias ff='fastfetch'

alias cls='clear'

alias c='cargo'
alias g='git'

sudo=sudo
if type doas > /dev/null; then
    sudo=doas
fi

if [[ -f /etc/os-release ]]; then
    if grep -q debian /etc/os-release; then
        alias u="${sudo} apt update && ${sudo} apt upgrade -y"
        alias i="${sudo} apt install -y"
        alias p="${sudo} apt purge --autoremove -y"
        alias s="apt search"
    elif grep -q void /etc/os-release; then
        alias u="${sudo} xbps-install -Syu"
        alias i="${sudo} xbps-install -y"
        alias p="${sudo} xbps-remove -Ry"
        alias s="xbps-query -Rs"
    fi
fi
