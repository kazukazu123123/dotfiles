#!/usr/bin/env bash

DOTPATH=~/.dotfiles

entries="\
.zshenv \
.zshrc \
.zimrc \
.zshrc.d \
.config/paru/paru.conf \
"

for f in $entries; do
    parent_dir=$(dirname "$HOME"/"$f")
    if [ ! -e "$parent_dir" ]; then
        mkdir -p "$parent_dir"
    fi
	ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
