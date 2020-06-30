source "$HOME/.sdkman/bin/sdkman-init.sh"
alias ggdiff="git diff --color | diff-so-fancy"
export PATH=$PATH:/home/jovannypcg/dev/vim-iced/bin

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
