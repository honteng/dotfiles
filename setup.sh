#!/bin/bash
cd ~
git clone https://github.com/honteng/dotfiles.git
cd dotfiles
./dotfiles_link.sh
git submodule init
git submodule update --recursive

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

if [[ $platform == 'linux' ]]; then
   sudo apt-get install zsh
   sudo cp ./linux/peco /usr/local/bin
   sudo chmod a+x /usr/local/bin/peco
fi
 
