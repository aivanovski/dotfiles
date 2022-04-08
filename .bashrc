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
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
PROMPT_256_COLOR=" ╭─\[\e[\033[01;34m\]\u@\h \[\e[38;5;211m\]\w\[\e[\033[38;5;48m\] $(parse_git_branch)\[\e[\033[00m\]\n ╰▶ \$ "
PROMPT_16_COLOR='\[\033[01;35m\][\u@\h\[\033[00m\] \[\033[0;35m\]\w\[\033[1;35m\]]\$\[\033[00m\] '

# Old prompt
# PROMPT_256_COLOR="\[\e[38;5;37m\][\u\[\033[00m\] \[\e[38;5;174m\]\w\[\e[38;5;37m\]]\$\[\e[00m\] "

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
        alias ls='lsd --icon never'
        alias ll='lsd --icon never -la'
        alias mc='mc --nosubshell'
        alias ctags='/usr/local/Homebrew/Cellar/ctags/5.8_2/bin/ctags'
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
alias findjar='find . -name "*.jar"'
alias vim='nvim'

# Tmux aliases
alias ta='tmux attach-session'
alias tk='tmux kill-server'

# Functions
if [ "$(uname | head -1)" == 'Darwin' ]; then
    gimp() { command /Applications/GIMP-2.10.app/Contents/MacOS/gimp "$@" > /dev/null 2>&1 & }
    meld() { command /Applications/Meld.app/Contents/MacOS/Meld "$@" > /dev/null 2>&2 & }
    tm()
    {
        tmux kill-server
        tmux new-session -d -n Ranger ranger && tmux new-window -n Terminal && tmux new-window -n Vim
        tmux selectw -t 1
        tmux -2 attach-session -d
    }
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
    "Linux")
        eval $(dircolors -b $HOME/.dircolors.256)
        ;;
esac

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""
