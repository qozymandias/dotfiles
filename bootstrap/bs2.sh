#!/bin/sh

## Nvim setup
NVIM_NAME="nvim.appimage"
NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/"$NVIM_NAME

sudo yum install -y nodejs npm;

pip3 install pynvim;

cd /opt \
    && curl -LO $NVIM_URL \
    && chmod +x ./nvim.appimage \
    && mv ./nvim.appimage /usr/local/bin/nvim;

RIPGREP_URL='https://github.com/BurntSushi/ripgrep/releases/download/0.5.2/ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz'; 
FD_URL="https://github.com/sharkdp/fd/releases/download/v7.3.0/fd-v7.3.0-x86_64-unknown-linux-musl.tar.gz";

cd /opt \
    && curl -LO $RIPGREP_URL \
    && tar xf ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz \
    && cp ripgrep-0.5.2-x86_64-unknown-linux-musl/rg /usr/local/bin/rg;

cd /opt \
    && curl -LO $FD_URL \
    && tar xf fd-v7.3.0-x86_64-unknown-linux-musl.tar.gz \
    && cp fd-v7.3.0-x86_64-unknown-linux-musl/fd /usr/local/bin/fd \
    && source fd-v7.3.0-x86_64-unknown-linux-musl/autocomplete/fd.bash-completion;

sudo wget http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle;

sudo yum install -y snapd \
    && sudo systemctl enable --now snapd.socket \
    && sudo ln -sf /var/lib/snapd/snap /snap;

sudo yum install -y libstdc++

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
