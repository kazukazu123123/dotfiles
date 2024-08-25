#!/usr/bin/env bash

DOTPATH=~/.dotfiles

entries="\
.zshrc \
.zimrc \
.zshrc.d \
"

for f in $entries; do
    parent_dir=$(dirname "$HOME"/"$f")
    if [ ! -e "$parent_dir" ]; then
        mkdir -p "$parent_dir"
    fi
	ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
