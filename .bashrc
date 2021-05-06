#
# ~/.bashrc
#

# Read ENV variable (which defines environment)
[[ -f $HOME/.config/environment ]] && . $HOME/.config/environment

# Init PATH variable
PATH=$PATH:$HOME/bin/android-sdk/platform-tools:$HOME/bin/android-sdk/emulator
PATH=$PATH:$HOME/.local/bin

case "$ENV" in
    "dev") ;;
    "home")
        PATH=$PATH:$HOME/bin/android-ndk-r15c
        ;;
esac

# Define bash prompt
PROMPT_256_COLOR="\[\e[38;5;37m\][\u\[\033[00m\] \[\e[38;5;174m\]\w\[\e[38;5;37m\]]\$\[\e[00m\] "
PROMPT_16_COLOR='\[\033[01;35m\][\u@\h\[\033[00m\] \[\033[0;35m\]\w\[\033[1;35m\]]\$\[\033[00m\] '

case "$TERM" in
    *"256color"*)
        PS1=$PROMPT_256_COLOR;;
    *"termite"*)
        PS1=$PROMPT_256_COLOR;;
    *)
        PS1=$PROMPT_16_COLOR;;
esac

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Turn off XON/XOFF signals (for Vim)
stty -ixon

# Alias
alias ls='ls --color'
alias ll='ls -la --color'
alias lln='ls -la --color=never'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias kee='kpcli --kdb $HOME/Yandex/Workspace/kp/kp.kdbx'
alias yd='yandex-disk'
alias rg='ranger'
alias ss='sudo systemctl'
alias wifi-network-list='nmcli d wifi list'
alias wifi-connect-existing='nmcli connection up'
alias wifi-connect-new='nmcli d wifi connect'
alias gitbook='docker run -it --rm --entrypoint=/bin/sh -v "$HOME/Yandex/GitBook":/gitbook -p 4000:4000 amontaigu/gitbook'
alias calendar='cal -m -n 6'
alias fzfh='cat $HOME/.bash_history | fzf'
alias pacgrep='pacman -Q | grep -i'

# Autocomplete
complete -cf sudo
complete -cf man

# History arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Bash history saving
shopt -s histappend

PROMPT_COMMAND='history -a; history -n'

# Bash history duplicates ignore
export HISTCONTROL="ignoreboth"
export HISTIGNORE="&:ls:[bf]g:exit: cd \"\`*: PROMPT_COMMAND=?*?"

# Bash history size
export HISTFILESIZE=10000

# Editor variables
export EDITOR="vim"
export VISUAL="vim"

# bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# fzf integration
case "$ENV" in
    "dev")
        [ -f ~/.fzf.bash ] && source ~/.fzf.bash
        ;;
    "home")
        if [ -f /usr/share/fzf/completion.bash ]; then
        	. /usr/share/fzf/completion.bash
        fi
        ;;
esac

eval $(dircolors -b $HOME/.dircolors.256)

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""
