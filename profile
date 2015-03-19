# vim: set syntax=sh :

export EDITOR=vim
export TERM=xterm-256color
export LESS=-R

eval "$(rbenv init -)"
export PATH="~/bin:/usr/local/heroku/bin:$PATH"

alias ls='ls -FG'
alias gpr='git pull --rebase'
alias gco='git checkout'
alias gpm='git push origin master'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_stash {
  [[ $(git stash list 2> /dev/null | tail -n1) != "" ]] && echo "^"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)$(parse_git_stash)/"
}
PS1='\[\e[0;33m\]\u@${HOSTNAME}\[\e[m\] \W \[\e[0;36m\]$(parse_git_branch)\[\e[m\] $ '

function glone {
  git clone git@github.com:$1.git
}
