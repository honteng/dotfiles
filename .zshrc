# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kolo"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git screen zsh-syntax-highlighting)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#

umask 0007
export HISTSIZE=10000
export TERM=xterm-color
export CLICOLOR=yes

export EDITOR=vim
export JAVA_TOOL_OPTIONS="-Dfile.encoding=utf8"
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"

alias ll='ls -alh'
alias vi=vim

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'
alias -g P='| peco'
alias -g X='| xargs'
alias -g V='| vim -'

alias fn='find . -name '
alias fin='find . -iname '
function f() { find . -iname "*$1*" ${@:2} }

alias memo='vi ~/Dropbox/done2.txt'
alias gogo='cd $GOPATH/src/github.com/honteng/'
MODE=$GOPATH/src/tinkermode.com/
alias mode='cd $MODE'

# DEV aliases
alias start_mongodb='mongod --dbpath ~/workspace/mongodb --rest 2>&1 > ~/workspace/logs/mongodb.log&'
alias topaz='mode && go run cloud/topaz/main/main.go 2>&1 | tee logs/topaz.log'
alias maze='mode && go run cloud/maze/main/maze_main.go 2>&1 | tee logs/maze.log'
alias epcot='mode && go run cloud/epcot/main/epcot.go 2>&1 | tee logs/epcot.log'
alias portal='cd $MODE/portal; rake && cd $GOPATH && go run src/tinkermode.com/portal/main/portal_main.go 2>&1 | tee $MODE/logs/portal.log'
alias mqtt='mode && go run cloud/mqtt/main/mqtts.go tcp localhost 1883 2>&1 | tee logs/mqtts.log'
alias metro='mode && go run cloud/metro/main/main.go 2>&1 | tee logs/metro.log'
alias hubble='mode && go run cloud/hubble/main/main.go 2>&1 | tee logs/hubble.log'

alias pi='screen -X screen /dev/cu.usbserial 115200'
alias edison='screen -X screen /dev/cu.usbserial-AJ035JTA 115200'
alias ika='cd $MODE/devices/tako/ua'
alias raml2html_mode='node ~/workspace/go/src/tinkermode.com/tools/raml2html/lib'

alias gittree='git log --graph --decorate --oneline'

function mec2() { ssh -i ~/.ssh/multimode1.pem mode@$1 ${@:2} }
function ec2() { ssh -i ~/.ssh/multimode1.pem ubuntu@$1 ${@:2} }

function ec2_cp() { scp -i ~/.ssh/multimode1.pem  ${@:1} }

# Docker
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1   

[[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
gvm use go1.5.3
export GOPATH=$HOME/workspace/go

export PATH=$GOPATH/bin:$PATH

# For autojump
# [[ -s /Users/honten/.autojump/etc/profile.d/autojump.sh ]] && source /Users/honten/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit

# Peco settings to search command
function exists { which $1 &> /dev/null }

if exists peco; then
  function peco-select-history() {
      local tac
      if which tac > /dev/null; then
          tac="tac"
      else
          tac="tail -r"
      fi
      BUFFER=$(\history -n 1 | \
          eval $tac | \
          peco --query "$LBUFFER")
      CURSOR=$#BUFFER
      zle clear-screen
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

fi

# GNU Screen setting for chaging title
preexec () {
  echo -ne "\ek${1%% *}\e\\"
}

#
# Peco base autojump
#
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history_file
function chpwd_record_history() {
    echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

function peco_get_destination_from_history() {
    sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
        sed -e 's/^[ ]*[0-9]*[ ]*//' | \
        sed -e s"/^${HOME//\//\\/}/~/" | \
        peco | xargs echo
}

function peco_cd_history() {
    local destination=$(peco_get_destination_from_history)
    [ -n $destination ] && cd ${destination/#\~/${HOME}}
    zle reset-prompt
}
zle -N peco_cd_history

function peco_insert_history() {
    local destination=$(peco_get_destination_from_history)
    if [ $? -eq 0 ]; then
        local new_left="${LBUFFER} ${destination}"
        BUFFER=${new_left}${RBUFFER}
        CURSOR=${#new_left}
    fi
    zle reset-prompt
}
zle -N peco_insert_history
# }}}

# C-j cd with peco
# C-j C-i insert dir with peco

bindkey '^j' peco_cd_history
bindkey '^x^i' peco_insert_history

# No beep
setopt nolistbeep

# Search with ag and open with peco


function age() {
  if [ $# -eq 1 ]; then
    ag --noheading $1 | peco | sed 's/^\(.*\):\(.*\):.*/\1 +\2/' | xargs $EDITOR
  else
    echo "Usage: age QUERY"
  fi
}


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Added for Java env
export JAVA_HOME=$(/usr/libexec/java_home)

### EC2 tools
export EC2_HOME=~/bin/ec2/ec2-api-tools-1.7.3.2/
export PATH=$PATH:$EC2_HOME/bin

## For 8266 toolchain
export PATH=$GOPATH/bin:$PATH
export PATH=/Volumes/case-sensitive/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

## ADB

export PATH=/Users/honten/Library/Android/sdk/platform-tools:$PATH
#
## For VerneMQ
export PATH=$PATH:/Users/honten/workspace/tmp/vernemq/_build/default/rel/vernemq/bin

# Docker
export DOCKER_HOST=tcp://192.168.99.100:2376
export DOCKER_MACHINE_NAME=default
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH=/Users/honten/.docker/machine/certs

# PostgreSQL
export PGDATA=/usr/local/var/postgres
alias pgstart="pg_ctl -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"


