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

PS1='%F{008}╭╴ $([ "$SESSION_TYPE" = remote/ssh ] && echo "(ssh) ")$([ "$is_chroot" = true ] && echo "(chroot) ")%(!.%F{009}%B.%F{012})%n%f%b%F{008} @ %F{012}%M%F{008} in %F{012}%~%f%b
%F{008}╰╴%f %(?.%F{001}.%F{004})❥%f '
PS2='%F{red}\ %f'
