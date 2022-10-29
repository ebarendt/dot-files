#!/usr/bin/env zsh

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
asdf plugin-add ruby
sudo apt-get install autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
