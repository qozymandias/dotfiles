#!/bin/sh

# snap daemon needs to be up 
sudo systemctl restart snapd.seeded.service \
    && sudo snap install ccls --classic \
    && sudo ln -s /var/lib/snapd/snap/ccls/current/bin/ccls /usr/local/bin/ccls;

sudo ln -sf /opt/rh/devtoolset-7/root/usr/bin/g++ /usr/bin/g++;
sudo ln -sf /opt/rh/devtoolset-7/root/usr/bin/gcc /usr/bin/gcc;

# MIGHT NEED TO RERUN THESE 
cp -r /opt/dotfiles/.vimrc /opt/dotfiles/.config $HOME;

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

sudo /usr/bin/python3 -m pip install pynvim;

sudo npm install -g tree-sitter;

mkdir -p ~/Documents/Gitlab/dvcs/Build;

# cd ~/Documents/Gitlab/dvcs \
#     && git clone git@gitlab-sfo.dolby.net:comms-cs/dvcs.git \
#     && mv dvcs/ Project;

# DONE Manually ATM
# conan config install --type=git git@gitlab-sfo.dolby.net:comms-cs/conan-config.git  #Make sure you have been granted access to the branch manually
# conan user <username> -p <password> -r dvsc # Replace the username and password with your Dolby Credentials

# git clone git@gitlab-sfo.dolby.net:comms-cs/dvcs.git;
