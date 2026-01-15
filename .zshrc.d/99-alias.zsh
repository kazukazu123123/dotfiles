alias reload='exec zsh'
alias ls='ls --color=auto'
alias la='ls -lah'
alias ff='fastfetch'

alias cls='clear'

alias c='cargo'
alias g='git'

alias dc='docker compose'
alias downrm='docker compose down --rmi=all --volumes --remove-orphans'

sudo=sudo
if type doas > /dev/null; then
    sudo=doas
fi

if [[ -f /etc/arch-release ]]; then
    aur_helpers=(aurman aurutils pakku pikaur trizen yay paru bauerbill pkgbuilder aura repofish wrapaur aurget pacman)

    for helper in ${aur_helpers}; do
        if type ${helper} > /dev/null; then
            aur=${helper}
            break
        fi
    done

    # If an AUR helper is found, disable direct pacman usage for interactive sessions
    if [[ "${aur}" != "pacman" ]]; then
        alias pacman='echo -e "\e[31;1mError: Direct usage of pacman is disabled. Please use '${aur}' instead.\e[0m"; false'
    fi

    if [[ ${aur} = pacman ]]; then
        if [[ ! -e ~/.dotfiles.aurignore ]] && read -q "REPLY?No AUR helper was found, do you want to install paru-bin from AUR? [y/N]: "; then
            echo
            echo -e '\n\e[30;1mCloning `\e[0mhttps://aur.archlinux.org/paru-bin.git\e[30;1m` into `\e[0m/tmp/paru\e[30;1m` ...\e[0m\n'
            git clone https://aur.archlinux.org/paru-bin.git /tmp/paru
            cd /tmp/paru
            echo -e '\n\e[30;1mRunning `\e[0mmakepkg -si --noconfirm\e[30;1m` ...\e[0m\n'
            makepkg -si --noconfirm
            cd ~
            echo -e '\n\e[30;1mRemoving `\e[0m/tmp/paru\e[30;1m` ...\e[0m'
            rm -rf /tmp/paru
            echo -e '\e[32;1mSuccess!\e[0m\n'
            aur=paru
            # Update alias to point to the newly installed paru
            alias pacman='echo -e "\e[31;1mError: Direct usage of pacman is disabled. Please use paru instead.\e[0m"; false'
        else
            touch ~/.dotfiles.aurignore
            aur="${sudo} ${aur}"
        fi
    fi

    alias u="${aur} -Syyu"
    alias i="${aur} -S"
    alias p="${aur} -R"
    alias s="${aur}"
elif [[ -f /etc/os-release ]] && grep -q debian /etc/os-release; then
    if type nala > /dev/null; then
        alias u="${sudo} nala upgrade -y"
        alias i="${sudo} nala install -y"
        alias p="${sudo} nala purge -y"
        alias s="nala search"
    else
        alias u="${sudo} apt update && ${sudo} apt upgrade -y"
        alias i="${sudo} apt install -y"
        alias p="${sudo} apt purge --autoremove -y"
        alias s="apt search"
    fi
elif [[ -f /etc/os-release ]] && grep -qE 'fedora|rhel' /etc/os-release; then
    alias u="${sudo} dnf update -y"
    alias i="${sudo} dnf install -y"
    alias p="${sudo} dnf erase -y"
    alias s="dnf search"
fi
