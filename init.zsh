source $CODEPATH/git/oh-my-env/zsh/install

plugins=($plugins git zsh-autosuggestions kubectl vi-mode kubectx golang ag history zsh-syntax-highlighting)

ZSH_THEME="spaceship"
zstyle ':omz:update' mode auto      # update automatically without asking

source $ZSH/oh-my-zsh.sh
source $CODEPATH/git/oh-my-env/zsh/export
source $CODEPATH/git/oh-my-env/zsh/alias
source $CODEPATH/git/oh-my-env/zsh/bindkey
source $CODEPATH/git/oh-my-env/zsh/function

# vim: set filetype=bash :
