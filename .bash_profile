#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/aivanouski/.sdkman"
[[ -s "/Users/aivanouski/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/aivanouski/.sdkman/bin/sdkman-init.sh"
