alias reload='exec zsh'
alias ls='ls --color=auto'
alias la='ls -lah'
alias ff='fastfetch'

sudo=sudo
if type doas > /dev/null; then
  sudo=doas
fi

if [[ -f /etc/os-release ]]; then
  case "$(grep ^ID= /etc/os-release | cut -d= -f2)" in
    debian)
      alias u='sudo apt update && sudo apt upgrade -y'
      alias i='sudo apt install -y'
      alias p='sudo apt purge --autoremove -y'
      alias s='apt search'
      ;;
    *)
      ;;
  esac
fi
