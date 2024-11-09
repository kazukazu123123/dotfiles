is_chroot=false
diff /proc/1/mountinfo /proc/self/mountinfo &>/dev/null
[ $? = 1 ] && is_chroot=true

# https://unix.stackexchange.com/a/9607/37523
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=remote/ssh
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE=remote/ssh;
    esac
fi

FG_GRAY='%F{008}'
FG_RED='%F{001}'
FG_GREEN='%F{002}'
FG_YELLOW='%F{003}'
FG_BLUE='%F{004}'
FG_CYAN='%F{006}'
FG_MAGENTA='%F{009}'
FG_WHITE='%F{012}'
RESET='%f%b'

# Color settings
FG_GRAY='%F{008}'
FG_RED='%F{001}'
FG_GREEN='%F{002}'
FG_YELLOW='%F{003}'
FG_BLUE='%F{004}'
FG_CYAN='%F{006}'
FG_MAGENTA='%F{009}'
FG_WHITE='%F{012}'
RESET='%f%b'

# Prompt elements
USER_PROMPT="${FG_MAGENTA}%(!.%B%n.%n)${RESET}"     # Username, changes depending on whether the user is root
HOST_PROMPT="${FG_WHITE}%M${RESET}"                 # Hostname
DIR_PROMPT="${FG_WHITE}%~${RESET}"                  # Current directory

# Session information
SESSION_PREFIX="${FG_GRAY}╭╴ "                     # Starting decoration
SSH_INDICATOR='$([ "$SESSION_TYPE" = remote/ssh ] && echo "(ssh) ")'  # Checks if it's an SSH session
CHROOT_INDICATOR='$([ "$is_chroot" = true ] && echo "(chroot) ")'     # Checks if it's a chroot session

# Status indicators
PROMPT_SUCCESS="${FG_RED}❥${RESET}"                # Prompt icon on command success
PROMPT_FAIL="${FG_BLUE}❥${RESET}"                  # Prompt icon on command failure

# Assembling the prompt
PS1="${SESSION_PREFIX}${SSH_INDICATOR}${CHROOT_INDICATOR}${USER_PROMPT}${FG_GRAY} @ ${HOST_PROMPT} in ${DIR_PROMPT}
${FG_GRAY}╰╴${RESET}%(?.${PROMPT_SUCCESS}.${PROMPT_FAIL}) "

# Secondary prompt
PS2='%F{red}\ %f'
