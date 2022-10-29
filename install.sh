#!/bin/bash

cwd=`pwd`

function copy {
  if [ ! -f ~/.$1 -a ! -L ~/.$1 ]; then
    echo "Linking $1"
    ln -s $(pwd)/$1 ~/.$1
  else
    echo "Skipping $1"
  fi
}

copy profile
copy irbrc
copy tmux.conf
copy inputrc
copy vimrc
copy gemrc
copy zshrc
copy fzf.zsh
copy gitignore_global

if [ ! -f ~/.gitconfig ]; then
  cp gitconfig ~/.gitconfig
fi

if [ ! -d ~/.vim/pack/minpac/opt/minpac ]; then
  git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
  vim +PackUpdate
fi

