export SCRUM_PREFIX=CP-
export GEM_HOME=/Users/jcruz/.rvm/gems
export GEM_PATH=/Users/jcruz/.rvm/gems

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jcruz/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="kolo"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jcruz/.sdkman"
[[ -s "/Users/jcruz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jcruz/.sdkman/bin/sdkman-init.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/jcruz/Library/DevSoft/vault-0.9.3/vault vault


function ec2PrivateIp() {
  aws ec2 describe-instances --region us-east-1 \
                             --output text \
                             --filter "Name=tag:Name,Values=$1"\
                             --query 'Reservations[*].Instances[*].PrivateIpAddress'
}

# get the private Ip address of a remote development environment for ssh etc.
function remoteDevIp() {
  ec2PrivateIp control-plane-000-$1
}

# get the SSL root Cert of a remote development environment for web browser
  # adds it to your keychain so it needs password confirmation
function addRemoteDevRootCA() {
  [[ $# == 0 ]] && echo "usage: addRemoteDevRootCA qe01" && return

  envName=$1
  certPath=~/.ssh/$envName\_rootCA.pem
  controlPlaneIp=$(remoteDevIp $envName)
  [[ -z $controlPlaneIp ]] && echo "No control plane IP for $envName" && return

  ssh -i ~/.ssh/remoteDevEnv.pem \
    centos@$controlPlaneIp \
    "sudo su -c 'cat /etc/haproxy/certs/cert-scripts/rootCA.pem'" > $certPath && \
      sudo security add-trusted-cert \
                    -d \
                    -r trustRoot \
                    -k /Library/Keychains/System.keychain "$certPath"
}

# retrieve the admin conf and store it in ~/.kubeconfigs
function refreshKubeConfig() {
  envName=$1
  configPath=~/.kubeconfigs/$envName.conf
  controlPlaneIp=$(remoteDevIp $envName)
  [[ -z $controlPlaneIp ]] && echo "No control plane IP for $envName" && return

  if [[ ! -s $configPath || $2 == '--force' ]]; then
    (>&2 echo "Overwriting $configPath")
    ssh -i ~/.ssh/remoteDevEnv.pem \
        centos@$controlPlaneIp \
        "sudo su -c 'cat /etc/kubernetes/admin.conf'" > $configPath 
  fi
  echo $configPath
}

# set KUBECONFIG so kubectl knows which dev env to talk to
function setKubeConfig() {
  [[ $# == 0 ]] && echo "usage: setKubeConfig qe01" && return

  export KUBECONFIG=$(refreshKubeConfig $@) && \
    echo "Retrieving a list of services for $KUBECONFIG" && \
      kubectl get services
}



export PATH="/Users/jcruz/.rvm/gems/ruby-2.5.1/bin:/Users/jcruz/.rvm/gems/ruby-2.5.1@global/bin:/Users/jcruz/.rvm/rubies/ruby-2.5.1/bin:/Users/jcruz/.rvm/bin:/Users/jcruz/.sdkman/candidates/springboot/current/bin:/Users/jcruz/.sdkman/candidates/scala/current/bin:/Users/jcruz/.sdkman/candidates/maven/current/bin:/Users/jcruz/.sdkman/candidates/java/current/bin:/Users/jcruz/.sdkman/candidates/groovy/current/bin:/Users/jcruz/.sdkman/candidates/gradle/current/bin:/Users/jcruz/.sdkman/candidates/ant/current/bin:/Library/Frameworks/Python.framework/Versions/3.7/bin:/Users/jcruz/.cargo/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/jcruz/.sdkman/candidates/java/current:/Users/jcruz/Library/Python/3.6/bin:/Users/jcruz/Library/DevSoft/liquibase-3.5.3/bin:/Users/jcruz/Library/DevSoft/protoc-java/bin:/Users/jcruz/Library/DevSoft/wtf-0.0.4:/Users/jcruz/Library/DevSoft/ngrok:/Users/jcruz/Library/DevSoft/spark-2.3.2-bin-hadoop2.7/bin:/Users/jcruz/.vimpkg/bin"
POWERLEVEL9K_MODE='nerdfont-complete'
source  ~/powerlevel9/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs newline status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

source $(dirname $(gem which colorls))/tab_complete.sh
alias lc='colorls -lA --sd'
alias mvim=/Applications/MacVim.app/Contents/bin/mvim
