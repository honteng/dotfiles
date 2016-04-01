#!/bin/sh
cd ~
git clone https://github.com/honteng/dotfiles.git
cd dotfiles
./dotfiles_link.sh
git submodule init
git submodule update --recursive

