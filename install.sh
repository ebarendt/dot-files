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

# Neovim (LazyVim) config lives in a directory, not a dotfile, so link it directly.
if [ ! -e ~/.config/nvim -a ! -L ~/.config/nvim ]; then
  echo "Linking nvim"
  mkdir -p ~/.config
  ln -s $(pwd)/nvim ~/.config/nvim
else
  echo "Skipping nvim"
fi

if [ ! -f ~/.gitconfig ]; then
  cp gitconfig ~/.gitconfig
fi

if [ ! -d ~/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
  sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
  # Fedora:
  # sudo dnf install -y autoconf gcc rust patch make bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel
fi

if [ ! -d ~/.vim/pack/minpac/opt/minpac ]; then
  git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
  vim +PackUpdate
fi

