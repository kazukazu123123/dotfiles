alias cdf="cd ~/.dotfiles"
alias dfu="zsh -c 'cd ~/.dotfiles && git stash -a && git switch main && git pull --ff-only && git switch - && git stash pop' && zimfw uninstall -q && zinfw install && zimfw update && exec zsh"
