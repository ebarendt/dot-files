#!/bin/bash

if [ ! -f ~/.inputrc -a ! -L ~/.tmux.conf ]; then
  ln -s tmux.conf ~/.tmux.conf
fi

if [ ! -f ~/.inputrc -a ! -L ~/.inputrc ]; then
  ln -s inputrc ~/.inputrc
fi

