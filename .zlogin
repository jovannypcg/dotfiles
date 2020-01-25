# ===== Environment variables =====

export JAVA_HOME=/Users/jcruz/.sdkman/candidates/java/current

export PATH=$PATH:$JAVA_HOME

# ===== Aliases =====

alias doco="docker-compose"
alias dcu="docker-compose up"
alias dcb="docker-compose build"
alias dcub="docker-compose up --build"
alias dosy="docker-sync"

alias ecr="$(aws ecr get-login --no-include-email --region us-east-1)"

alias lfmt="lein cljfmt fix"
alias lns="lein nsorg -e"
