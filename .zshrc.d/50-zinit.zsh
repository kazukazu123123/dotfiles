repo=https://github.com/zdharma-continuum/zinit.git
if [[ ! -a ~/.zinit     ]]; then mkdir -p ~/.zinit; fi
if [[ ! -a ~/.zinit/bin ]]; then git clone $repo ~/.zinit/bin; fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
autoload -Uz compinit && compinit
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zinit cdclear -q
setopt promptsubst

alias _lazy='zinit ice wait silent'

_lazy; zinit load zsh-users/zsh-autosuggestions
_lazy; zinit load zsh-users/zsh-history-substring-search
_lazy; zinit load zdharma-continuum/history-search-multi-word
       zinit load zdharma-continuum/fast-syntax-highlighting

       zinit snippet OMZP::history
       zinit snippet ~/.dotfiles/theme.zsh-theme

       zstyle ':omz:alpha:lib:git' async-prompt no

unalias _lazy

bindkey "^R" history-search-multi-word
