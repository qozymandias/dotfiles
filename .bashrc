#!/bin/bash

HISTCONTROL=ignoreboth
HISTSIZE=2500
HISTFILESIZE=5000

shopt -s histappend
shopt -s checkwinsize

PS1="\[\033[01;31m\]\u\[\033[00m\]@\[\033[01;31m\]\h\[\033[00m\]:\[\033[03;34m\]\w\[\033[00m\] \[\033[35;4m\]\`parse_git_branch\`\[\033[00m\] \[\033[93;1m\][\T]\[\033[00m\]\n--> "

[ -f /etc/bash_completion ] && source /etc/bash_completion
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
[ -f "$HOME/.bash_functions" ] && source "$HOME/.bash_functions"
[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"

export VIM_FILES="$HOME.vim"
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++

export LANG=en_GB.UTF-8
export BASH_SILENCE_DEPRECATION_WARNING=1
export ASAN_OPTIONS=detect_leaks=0

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export NVIM_PYTHON_LOG_FILE=$HOME/.cache/nvim/nvim-python.log

# https://developer.nvidia.com/cuda-downloads
export CUDA_HOME=/usr/local/cuda
export PATH="$PATH:$CUDA_HOME/bin:$HOME/dev/nvim/nvim-linux-x86_64/bin:$HOME/.npm-global/bin:$HOME/dev/nvim/lua-language-server/bin:$HOME/dev/nvim/marksman"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CUDA_HOME/lib64:$HOME/dev/nvim/nvim-linux-x86_64/lib"
export NPM_CONFIG_PREFIX=$HOME/.npm-global
source "$HOME/.cargo/env"
export RAYON_NUM_THREADS=24
export CARGO_BUILD_JOBS=24
export PATH=$HOME/.npm-global/bin:$PATH
