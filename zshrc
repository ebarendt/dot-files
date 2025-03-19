# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="afowler"
#ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git heroku)
plugins=(asdf brew direnv aws)

source $ZSH/oh-my-zsh.sh

set -o vi

alias glr="git pull --rebase"
alias gco="git co"
alias gpr="git pull --rebase"
alias gpm="git push origin master"
alias be="bundle exec"

setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
SAVEHIST=100000

export PATH="/usr/local/bin:/opt/homebrew/opt/libpq/bin:$PATH"
export EDITOR=/usr/local/bin/vim

#autoload bashcompinit
#bashcompinit

autoload -U compinit; compinit

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.zshrc-local ]] && source ~/.zshrc-local

setopt auto_cd
export cdpath=(. ~ ~/src/)

export AWS_PAGER=""
eval "$(gh copilot alias -- zsh)"
