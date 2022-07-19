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
    && ln -sf /opt/cmake/bin/cmake /usr/bin/cmake \
    && ln -sf /opt/cmake/bin/cpack /usr/bin/cpack \
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
        libtool;

        # doxygen \
        # doxygen-latex \
        # doxygen-doxywizard;
        # && sudo yum -y clean all;

sudo . /opt/rh/rh-python36/enable \
&& sudo . /opt/rh/rh-git29/enable \
&& sudo source /opt/rh/rh-python36/enable;

sudo pip3 install --upgrade pip;

sudo pip3 install 'pytest==3.5' 'conan==1.45.0' boto cppcheck-junit junit-xml Pebble virtualenv six==1.14 psutil matplotlib;
# python-prctl 

wget https://bootstrap.pypa.io/pip/2.7/get-pip.py \
    && python2 get-pip.py \
    && pip install lxml  'matplotlib==2.2.4';
# python-prctl

# Install libraries for test_client (dvclient)
# sudo yum install -y pulseaudio-libs-devel.x86_64 \
#     && rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro \
#     && rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm \
#     && sudo yum install ffmpeg ffmpeg-devel -y \
#     && curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /bin/youtube-dl \
#     && chmod a+rx /bin/youtube-dl \
#     && sudo yum -y clean all;

cd /opt/rh/devtoolset-7/root/usr/bin \
    && ln -sf /usr/bin/make gmake ;
