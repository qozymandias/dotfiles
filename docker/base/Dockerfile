FROM oraclelinux:7-slim

# Single RUN/layer results in the smallest image size (relative to multiple RUN commands)

# rpms store here: https://gitlab-sfo.dolby.net/comms-cs/dvcs-docker.git gitlab yaml should clone them
COPY data ./data
RUN rpm -Uvh \
        data/rpms/c-ares-1.16.0-1.0.cf.rhel6.x86_64.rpm \
        data/rpms/curl-7.69.1-1.1.cf.rhel6.x86_64.rpm \
        data/rpms/libcurl-7.69.1-1.1.cf.rhel6.x86_64.rpm \
        data/rpms/libmetalink-0.1.3-10.rhel6.x86_64.rpm \
        data/rpms/libssh2-1.8.2-1.0.cf.rhel6.x86_64.rpm

# Install standard packages
# Get CMake version required by DVMS
# Get lcov
# Enable Software Collections
# Install packages only available with Software Collections
# Install required python3 modules
# Install required python2 modules
# Reduce image size by removing unnecessary files and packages and cleaning repository cache
RUN yum install -y wget tar vi which gcc git tcpdump rpm-build sudo bc nfs-utils \
    && rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
    && rpm -iUvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum-config-manager --enable epel-release \
    && rpm -iUvh http://li.nux.ro/download/nux/dextop/el7/x86_64/libx86emu-1.1-2.1.x86_64.rpm \
    && yum install -y hwinfo \
    && mkdir -p /opt/cmake \
    && wget -q -O- https://github.com/Kitware/CMake/releases/download/v3.16.5/cmake-3.16.5-Linux-x86_64.tar.gz | tar xz --strip-components 1 -C /opt/cmake \
    && ln -s /opt/cmake/bin/cmake /usr/bin/cmake && ln -s /opt/cmake/bin/cpack /usr/bin/cpack \
    && wget -q -O- http://downloads.sourceforge.net/ltp/lcov-1.13.tar.gz | tar xz -C /opt && cd /opt/lcov-1.13 && make install && cd -\
    && wget -O /etc/yum.repos.d/public-yum-ol7.repo https://yum.oracle.com/public-yum-ol7.repo \
    && yum-config-manager --enable ol7_software_collections \
    && yum-config-manager --enable ol7_optional_latest \
    && yum install -y \
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
        doxygen-doxywizard \
        && yum -y clean all \
        && . /opt/rh/rh-python36/enable \
        && . /opt/rh/rh-git29/enable \
        && pip3 install --upgrade pip \
        && pip3 install junit-xml \
        && pip3 install 'pytest==3.5' 'conan==1.45.0' boto cppcheck-junit junit-xml Pebble virtualenv python-prctl six==1.14 psutil matplotlib\
        && . /opt/rh/python27/enable \
        && wget https://bootstrap.pypa.io/pip/2.7/get-pip.py \
        && python2 get-pip.py \
        && pip install lxml python-prctl 'matplotlib==2.2.4'\
        && rm -rf /opt/rh/rh-python36/root/usr/share /opt/rh/devtoolset-7/root/usr/share/man /opt/rh/devtoolset-7/root/usr/share/locale


# Install libraries for test_client (dvclient)
RUN yum install -y pulseaudio-libs-devel.x86_64 \
    && rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro \
    && rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm \
    && yum install ffmpeg ffmpeg-devel -y \
    && curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /bin/youtube-dl \
    && chmod a+rx /bin/youtube-dl \
    && yum -y clean all

RUN (cd /opt/rh/devtoolset-7/root/usr/bin && ln -s /usr/bin/make gmake)

LABEL version="v2.0"
