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

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  mkdir -p ~/.vim/bundle
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
else
  echo "Vundle already installed"
fi
