#!/bin/sh

# snap daemon needs to be up 
# @todo some form of polling

sudo systemctl restart snapd.seeded.service \
    && sudo snap install ccls --classic \
    && sudo ln -s /var/lib/snapd/snap/ccls/current/bin/ccls /usr/local/bin/ccls;



# MIGHT NEED TO RERUN THESE 
cp -r /opt/dotfiles/.vimrc /opt/dotfiles/.config $HOME;

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';



# sudo yum install -y gcc-c++;
# 
# mkdir ~/Documents/Gitlab/           # To store all cloned repositories
# mkdir ~/Documents/Gitlab/dvcs       # To store everything related to our system
# mkdir ~/Documents/Gitlab/dvcs/Build # To store all build materials
# 
# cd ~/Documents/Gitlab/dvcs \
#     && git clone git@gitlab-sfo.dolby.net:comms-cs/dvcs.git \
#     && mv dvcs/ Project;

# DONE Manually ATM
# conan config install --type=git git@gitlab-sfo.dolby.net:comms-cs/conan-config.git  #Make sure you have been granted access to the branch manually
# conan user <username> -p <password> -r dvsc # Replace the username and password with your Dolby Credentials

# git clone git@gitlab-sfo.dolby.net:comms-cs/dvcs.git;
