#!/bin/bash

if [ ! -f ~/.inputrc -a ! -L ~/.tmux.conf ]; then
  ln -s tmux.conf ~/.tmux.conf
fi

if [ ! -f ~/.inputrc -a ! -L ~/.inputrc ]; then
  ln -s inputrc ~/.inputrc
fi

if [ ! -f ~/.vimrc -a ! -L ~/.vimrc ]; then
  ln -s vimrc ~/.vimrc
fi

if [ ! -d ~/.vim/bundle/ctrlp.vim ]; then
  cd ~/.vim
  git clone git://github.com/kien/ctrlp.vim.git
fi 
