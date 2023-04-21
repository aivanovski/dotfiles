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

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Turn off XON/XOFF signals (for Vim)
stty -ixon

# Aliases
case "$(uname | head -1)" in
    "Darwin")
        alias mc='mc --nosubshell'
        alias ctags='/usr/local/Homebrew/Cellar/ctags/5.8_2/bin/ctags'
        ;;
    "Linux")
        alias kee='kpcli --kdb $HOME/Yandex/Workspace/kp/kp.kdbx'
        alias yd='yandex-disk'
        alias ss='sudo systemctl'
        alias wifi-network-list='nmcli d wifi list'
        alias wifi-connect-existing='nmcli connection up'
        alias wifi-connect-new='nmcli d wifi connect'
        alias gitbook='docker run -it --rm --entrypoint=/bin/sh -v "$HOME/Yandex/GitBook":/gitbook -p 4000:4000 amontaigu/gitbook'
        alias pacgrep='pacman -Q | grep -i'
        alias pacfp='pacman -Qq | fzf --preview "pacman -Qil {}" --layout=reverse --bind "enter:execute(pacman -Qil {} | less)"'
        # Rate and sort latest 10 mirrors by download speed and write them to /etc/pacman.d/mirrorlist
        alias reflector-update='reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
        ;;
esac

alias ls='lsd --icon never'
alias ll='lsd --icon never -la'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias calendar='cal -m -n 6'
alias fzfh='cat $HOME/.bash_history | fzf'
alias findapk='find . -name "*.apk"'
alias findjar='find . -name "*.jar"'
alias findfile='find . -name '
alias vim='nvim'
alias adbtext='adb shell input text'

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

case "$(uname | head -1)" in
    "Darwin")
        # add ruby gem directory to path
        if [ -d $HOME/.gem/ruby/2.6.0/bin ]; then
            PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
        fi

        # brew
        if [ -f $HOME/.homebrew_profile ]; then
            source $HOME/.homebrew_profile
        fi

        # git prompt
        if [ -f "$(brew --prefix git)/etc/bash_completion.d/git-prompt.sh" ]; then
            GIT_PS1_SHOWDIRTYSTATE=1
            GIT_PS1_SHOWUPSTREAM=1
            source "$(brew --prefix git)/etc/bash_completion.d/git-prompt.sh"
        fi

        # expoty JAVA_HOME variable
        if [ -d /Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home ]; then
            export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
        fi
        ;;
    "Linux")
        # add ruby gem directory to path
        if [ -d $HOME/.local/share/gem/ruby/3.0.0/bin ]; then
            PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin
        fi

        # git prompt
        if [ -f /usr/share/git/completion/git-prompt.sh ]; then
            GIT_PS1_SHOWDIRTYSTATE=1
            GIT_PS1_SHOWUPSTREAM=1
            source /usr/share/git/completion/git-prompt.sh
        fi

        # bash completion
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            source /usr/share/bash-completion/bash_completion
        fi

        # fzf integration
        if [ -f /usr/share/fzf/completion.bash ]; then
            source /usr/share/fzf/completion.bash
        fi
        ;;
esac

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""

PROMPT_256_COLOR='╭─\[\e[\033[1;36m\]\u@\h \[\e[38;5;211m\]\w\[\e[\033[38;5;48m\] $(__git_ps1 " (%s)")\[\e[\033[00m\]\n╰▶ \$ '
PROMPT_16_COLOR=' \[\033[32m\]\u@\h\[\033[00m\] \[\033[0;31m\]\w\[\033[1;31m\]\[\033[00m\]\n ▶ \$ '

# Old prompt
# PROMPT_256_COLOR="\[\e[38;5;37m\][\u\[\033[00m\] \[\e[38;5;174m\]\w\[\e[38;5;37m\]]\$\[\e[00m\] "

case "$TERM" in
    *"256color"*)
        PS1=$PROMPT_256_COLOR;;
    *)
        PS1=$PROMPT_16_COLOR;;
esac
