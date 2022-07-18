#!/bin/sh

yum install -y nodejs npm python3 && \
pip3 install --user pynvim;

NVIM_NAME="nvim.appimage"
NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/"$NVIM_NAME
curl -LO $NVIM_URL
chmod +x ./nvim.appimage
mv ./nvim.appimage /usr/local/bin/nvim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
