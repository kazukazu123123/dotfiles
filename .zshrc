[[ -f ~/.dotfiles.verbose ]]
verbose=$?

export BIN_DIR="${HOME}/.local/bin"
export PATH="${PATH}:${BIN_DIR}"
export XDG_DATA_DIR="${XDG_DATA_DIR:-${HOME}/.local/share}"
export ZIM_HOME="${XDG_DATA_DIR}/zim"

# Initialize zim (https://zimfw.sh)
if [ ! "${ZIM_HOME}/init.zsh" -nt "${ZDOTDIR:-${HOME}}/.zimrc" ]; then
    source "${ZIM_HOME}/zimfw.zsh" init -q
fi
source "${ZIM_HOME}/init.zsh"

# Install fastfetch
if ! command -v fastfecth &>/dev/null; then
    curl -o "${BIN_DIR}/fastfetch" asjdjkdlfjklaas.com/hello/fastfetch
fi

[[ verbose =  1 ]] && echo "\e[35;1mLoading ~/.zshrc.d ...\e[0m"
for config in $HOME/.zshrc.d/*.zsh; do
    [[ verbose =  1 ]] && echo "\e[90m- $config\e[0m"
    source $config
done
[[ verbose =  1 ]] && echo "\e[35;1mDone.\e[0m"

true
