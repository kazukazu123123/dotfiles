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

# Git snippet
zinit snippet OMZL::git.zsh

# Auto suggestions
_lazy; zinit load zsh-users/zsh-autosuggestions

# History search
_lazy; zinit load zsh-users/zsh-history-substring-search

# History search (multi-word)
_lazy; zinit load zdharma-continuum/history-search-multi-word

# Syntax higilight
zinit load zdharma-continuum/fast-syntax-highlighting

# Theme
zinit snippet ~/.dotfiles/theme.zsh-theme

unalias _lazy

bindkey "^R" history-search-multi-word
