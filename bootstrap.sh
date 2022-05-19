#!/bin/bash

NVIM_NAME=""
NVIM_URL=""

if [ "$(uname)" == "Darwin" ]; then
    NVIM_NAME="nvim-macos.tar.gz"
    NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/"$NVIM_NAME
    curl -LO $NVIM_URL
    tar xzf nvim-macos.tar.gz
    sudo rsync -a nvim-osx64/* /usr/local/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    NVIM_NAME="nvim.appimage"
    NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/"$NVIM_NAME
    curl -LO $NVIM_URL
    chmod u+x ./nvim.appimage
    mv ./nvim.appimage /usr/local/bin/nvim
fi

nvim +'PlugInstall'
