
# Cmake 
RUN yum install -y wget && \
    wget https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz && \
    tar zxvf cmake-3.* && \
    cd cmake-3.* && \
    ./bootstrap --prefix=/usr/local && \
    make -j$(nproc) && \
    make install && \
    cmake --version;


## Install 
RUN git clone https://github.com/neovim/neovim.git && \
    cd neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    sudo make install;



