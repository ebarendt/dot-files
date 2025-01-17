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

if [ ! -f ~/.zshrc ]; then
  sudo apt install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  rm ~/.zshrc
fi

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

if [ ! -d ~/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
  sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
fi

if [ ! -d ~/.vim/pack/minpac/opt/minpac ]; then
  git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
  vim +PackUpdate
fi

