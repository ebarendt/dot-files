# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="afowler"

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

export PATH="/usr/local/bin:/usr/local/heroku/bin:$PATH"
export EDITOR=/usr/local/bin/vim

autoload bashcompinit
bashcompinit

export PYENV_ROOT="$HOME/.pyenv"
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$PYENV_ROOT/bin:$RBENV_ROOT/bin:$PATH"

[[ -d $PYENV_ROOT ]] && eval "$(pyenv init -)"
[[ -d $RBENV_ROOT ]] && eval "$(rbenv init -)"

type axl > /dev/null && eval $(axl bash_complete)

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.zshrc-local ]] && source ~/.zshrc-local

