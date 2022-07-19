#!/bin/sh

sudo yum install -y wget tar vi which gcc git tcpdump rpm-build sudo bc nfs-utils rsync;

cd /opt/ \
    && git clone https://github.com/qozymandias/dotfiles.git \
    && cd /opt/dotfiles/docker/base \
    && rpm -Uvh \
        ./data/rpms/c-ares-1.16.0-1.0.cf.rhel6.x86_64.rpm \
        ./data/rpms/curl-7.69.1-1.1.cf.rhel6.x86_64.rpm \
        ./data/rpms/libcurl-7.69.1-1.1.cf.rhel6.x86_64.rpm \
        ./data/rpms/libmetalink-0.1.3-10.rhel6.x86_64.rpm \
        ./data/rpms/libssh2-1.8.2-1.0.cf.rhel6.x86_64.rpm \
    && cd /opt/;

# DVCS setup
rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
    && rpm -iUvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && sudo yum-config-manager --enable epel-release \
    && rpm -iUvh http://li.nux.ro/download/nux/dextop/el7/x86_64/libx86emu-1.1-2.1.x86_64.rpm \
    && sudo yum install -y hwinfo \
    && mkdir -p /opt/cmake;

wget -q -O- https://github.com/Kitware/CMake/releases/download/v3.16.5/cmake-3.16.5-Linux-x86_64.tar.gz | tar xz --strip-components 1 -C /opt/cmake \
    && ln -s /opt/cmake/bin/cmake /usr/bin/cmake \
    && ln -s /opt/cmake/bin/cpack /usr/bin/cpack \
    && wget -q -O- http://downloads.sourceforge.net/ltp/lcov-1.13.tar.gz | tar xz -C /opt \
    && cd /opt/lcov-1.13 && make install \
    && cd -\
    && wget -O /etc/yum.repos.d/public-yum-ol7.repo https://yum.oracle.com/public-yum-ol7.repo \
    && sudo yum-config-manager --enable ol7_software_collections \
    && sudo yum-config-manager --enable ol7_optional_latest;

sudo yum install -y \
        devtoolset-7-gcc-c++ \
        devtoolset-7-libasan-devel \
        devtoolset-7-libubsan-devel \
        devtoolset-7-libtsan-devel \
        devtoolset-7-liblsan-devel \
        python27-python \
        python27-python-devel \
        rh-python36-python \
        rh-python36-python-devel \
        rh-git29-git \
        glib2-devel \
        libcap-devel \
        libpcap-devel \
        zlib-devel \
        cppcheck \
        libtool \
        doxygen \
        doxygen-latex \
        doxygen-doxywizard;

        # && sudo yum -y clean all;


# . /opt/rh/rh-python36/enable \
#       && . /opt/rh/rh-git29/enable \
pip3 install --upgrade pip;

pip3 install junit-xml 'pytest==3.5' 'conan==1.45.0' boto cppcheck-junit junit-xml Pebble virtualenv six==1.14 psutil matplotlib;
# python-prctl 

wget https://bootstrap.pypa.io/pip/2.7/get-pip.py \
    && python2 get-pip.py \
    && pip install lxml python-prctl 'matplotlib==2.2.4';

# Install libraries for test_client (dvclient)
sudo yum install -y pulseaudio-libs-devel.x86_64 \
    && rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro \
    && rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm \
    && sudo yum install ffmpeg ffmpeg-devel -y \
    && curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /bin/youtube-dl \
    && chmod a+rx /bin/youtube-dl \
    && sudo yum -y clean all;

cd /opt/rh/devtoolset-7/root/usr/bin \
    && ln -s /usr/bin/make gmake \
    && cd /opt/;

# source /opt/rh/rh-python36/enable;

## Nvim setup
NVIM_NAME="nvim.appimage"
NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/"$NVIM_NAME

sudo yum install -y nodejs npm;

sudo pip3 install pynvim;

cd /opt \
    && curl -LO $NVIM_URL \
    && chmod +x ./nvim.appimage \
    && mv ./nvim.appimage /usr/local/bin/nvim;

cd /opt/dotfiles \
    && ./push.sh \
    && cd ~/;

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
    && sudo ln -s /var/lib/snapd/snap /snap \
    && sleep 30 \
    && sudo snap install ccls --classic \
    && sudo ln -s /var/lib/snapd/snap/ccls/current/bin/ccls /usr/local/bin/ccls;


# sudo yum install -y gcc-c++;
# 
# mkdir ~/Documents/Gitlab/           # To store all cloned repositories
# mkdir ~/Documents/Gitlab/dvcs       # To store everything related to our system
# mkdir ~/Documents/Gitlab/dvcs/Build # To store all build materials
# 
# cd ~/Documents/Gitlab/dvcs \
#     && git clone git@gitlab-sfo.dolby.net:comms-cs/dvcs.git \
#     && mv dvcs/ Project;

sudo yum install -y libstdc++

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

# DONE Manually ATM
# conan config install --type=git git@gitlab-sfo.dolby.net:comms-cs/conan-config.git  #Make sure you have been granted access to the branch manually
# conan user <username> -p <password> -r dvsc # Replace the username and password with your Dolby Credentials

# git clone git@gitlab-sfo.dolby.net:comms-cs/dvcs.git;
