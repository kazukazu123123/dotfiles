alias cdf="cd ~/.dotfiles"
alias dfu="zsh -c 'cd ~/.dotfiles && git stash -a && git switch main && git pull --ff-only && git switch - && git stash pop' && zimfw uninstall -q && zimfw install && zimfw update && exec zsh"
