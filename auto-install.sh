#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git and try again."
    exit 1
fi

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Error: zsh is not installed. Please install zsh and try again."
    exit 1
fi

# If .dotfiles directory exists, prompt user to delete and recreate it
if [[ -d ~/.dotfiles ]]; then
    echo "~/.dotfiles directory already exists."
    read -p "Do you want to delete and recreate it? (y/n): " answer
    if [[ $answer =~ ^[Yy]$ ]]; then
        rm -rf ~/.dotfiles
        echo "Deleted ~/.dotfiles directory."
    else
        echo "Aborting installation."
        exit 1
    fi
fi

# Clone the repository if the dotfiles directory is empty
if [[ -z "$(ls -A ~/.dotfiles 2> /dev/null)" ]]; then
    git clone https://github.com/kazukazu123123/dotfiles ~/.dotfiles || { echo "Failed to clone repository."; exit 1; }
fi

# Execute install.sh and capture the exit status
if ./install.sh; then
    echo "Type 'exec zsh' to reload your shell and enjoy!"
else
    echo "Installation encountered issues. Please review the output above for details."
    exit 1
fi

# Additional notes
echo "Note: To enable verbose logging, create a file named '~/.dotfiles.verbose'."
echo
echo "Note: 'source .zshrc' is deprecated. For more information, visit:"
echo "https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html"
