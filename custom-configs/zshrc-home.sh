# Path to your oh-my-zsh installation.
export ZSH="/Users/poginni/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git, vscode, compleat
)
source $ZSH/oh-my-zsh.sh

# Personal shell aliases
alias kd='kitchen destroy'
alias kv='kitchen verify'

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

export NVM_DIR='$HOME/.nvm'
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ta="terraform apply"
alias td="terraform destroy"
alias ti="terraform init"
alias tp="terraform plan"

# Anaconda
alias conda2="/Users/poginni/miniconda2/bin/conda"
alias conda3="/Users/poginni/miniconda3/bin/conda"
alias conda="/Users/poginni/miniconda3/bin/conda"

ag='ag --color --ignore-dir node_modules --ignore-dir .terraform'

alias dp='docker prune -a'

# Nvim
alias n='nvim'

# Python
alias p='python'

# Tmux
alias t='tmux new -s ${1}' # New named session

# FZF
alias f='nvim $(fzf)'

# List
alias l='ls -ltra'
alias ll='ls -ltra'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
