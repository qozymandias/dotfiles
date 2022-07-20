#!/bin/sh

## Nvim setup
NVIM_NAME="nvim.appimage"
NVIM_URL="https://github.com/neovim/neovim/releases/download/stable/"$NVIM_NAME

sudo yum install -y nodejs npm;

pip3 install --user pynvim;

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
