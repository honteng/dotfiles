bindkey -e

###########################################################
# Pre configuration

# Define the environment variable ZPLUG_HOME
export ZPLUG_HOME=/usr/local/opt/zplug

# Loads zplug
source $ZPLUG_HOME/init.zsh

# Clear packages
zplug clear

###########################################################
# Packages

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "paulmelnikow/zsh-startup-timer"
zplug "tysonwolker/iterm-tab-colors"
# zplug "peterhurford/up.zsh"
zplug "jimeh/zsh-peco-history"
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

###########################################################
# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

# GNU Screen setting for chaging title
preexec () {
  echo -ne "\ek${1%% *}\e\\"
}

unsetopt no_share_history
export DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent
setopt auto_cd pushd_ignore_dups share_history
setopt INC_APPEND_HISTORY

umask 0006
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000000

# export TERM=xterm-color
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

export EDITOR=vim
export JAVA_TOOL_OPTIONS="-Dfile.encoding=utf8"
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"

alias ll='ls -alh'
alias vi=vim

function f() { find . -iname "*$1*" ${@:2} }
# No beep
setopt nolistbeep

autoload -U compinit && compinit

setopt auto_param_slash
setopt mark_dirs
# setopt list_types
setopt auto_menu
setopt auto_param_keys
# setopt interactive_comments
setopt magic_equal_subst

setopt complete_in_word
setopt always_last_prompt

setopt print_eight_bit
setopt extended_glob
setopt globdots

setopt auto_cd
setopt autocd autopushd pushdminus pushdsilent cdablevars

if [[ -e ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi


