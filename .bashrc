#
# ~/.bashrc
#

# Read ENV variable (which defines environment)
[[ -f $HOME/.config/environment ]] && . $HOME/.config/environment

if [ -d $HOME/bin/android-sdk ]; then
    PATH=$PATH:$HOME/bin/android-sdk/platform-tools:$HOME/bin/android-sdk/emulator
fi

if [ -d $HOME/.local/bin ]; then
    PATH=$PATH:$HOME/.local/bin
fi

if [ -d $HOME/.local/share/gem/ruby/3.0.0/bin ]; then
    PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin
fi

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
case "$(uname | head -1)" in
    "Darwin")
        alias ls='gls --color'
        alias ll='gls -la --color'
        alias lln='gls -la --color=never'
        alias mc='mc --nosubshell'
        ;;
    "Linux")
        alias ls='ls --color'
        alias ll='ls -la --color'
        alias lln='ls -la --color=never'
        alias kee='kpcli --kdb $HOME/Yandex/Workspace/kp/kp.kdbx'
        alias yd='yandex-disk'
        alias ss='sudo systemctl'
        alias wifi-network-list='nmcli d wifi list'
        alias wifi-connect-existing='nmcli connection up'
        alias wifi-connect-new='nmcli d wifi connect'
        alias gitbook='docker run -it --rm --entrypoint=/bin/sh -v "$HOME/Yandex/GitBook":/gitbook -p 4000:4000 amontaigu/gitbook'
        alias pacgrep='pacman -Q | grep -i'
        # Rate and sort latest 10 mirrors by download speed and write them to /etc/pacman.d/mirrorlist
        alias reflector-update='reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
        ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias rg='ranger'
alias calendar='cal -m -n 6'
alias fzfh='cat $HOME/.bash_history | fzf'
alias findapk='find . -name "*.apk"'
alias vim='nvim'

# Tmux aliases
alias ta='tmux attach-session'
alias tk='tmux kill-server'

# Functions
if [ "$(uname | head -1)" == 'Darwin' ]; then
    gimp() { command /Applications/GIMP-2.10.app/Contents/MacOS/gimp "$@" > /dev/null 2>&1 & }
    meld() { command /Applications/Meld.app/Contents/MacOS/Meld "$@" > /dev/null 2>&2 & }
fi

# Autocomplete
complete -cf sudo
complete -cf man

# History search with Up and Down arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# History search with Ctrl-K and Ctrl-J
bind '"\C-k": history-search-backward'
bind '"\C-j": history-search-forward'

# Bash history saving
shopt -s histappend

PROMPT_COMMAND='history -a; history -n'

# Bash history duplicates ignore
export HISTCONTROL="ignoredups:erasedups"
export HISTIGNORE="&:ls:[bf]g:exit: cd \"\`*: PROMPT_COMMAND=?*?"

# Bash history size
export HISTFILESIZE=10000

# Editor variables
export EDITOR="nvim"
export VISUAL="nvim"

# bash completion
case "$(uname | head -1)" in
    "Darwin")
        [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
        ;;
    "Linux")
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        fi
        ;;
esac


# fzf integration
if [ -f /usr/share/fzf/completion.bash ]; then
	. /usr/share/fzf/completion.bash
fi

case "$(uname | head -1)" in
    "Darwin")
        eval $(gdircolors -b $HOME/.dircolors.256)
        ;;
    "Linux")
        eval $(dircolors -b $HOME/.dircolors.256)
        ;;
esac

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""
