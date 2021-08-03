#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [ "$(uname | head -1)" == 'Darwin' ]; then
    export SDKMAN_DIR="/Users/aivanouski/.sdkman"
    [[ -s "/Users/aivanouski/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/aivanouski/.sdkman/bin/sdkman-init.sh"
fi
