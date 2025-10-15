#!/bin/bash

HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=10000
export HISTIGNORE="*download.sh*:*remove_album_prefix.sh*:*Album*"

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
export ASAN_OPTIONS=detect_leaks=0

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export NVIM_PYTHON_LOG_FILE=$HOME/.cache/nvim/nvim-python.log

# CUDA env variables, see installation here https://developer.nvidia.com/cuda-downloads
export CUDA_HOME=/usr/local/cuda
export PATH="$PATH:$CUDA_HOME/bin:$HOME/dev/nvim/nvim/bin:$HOME/.npm-global/bin:$HOME/dev/nvim/lua-language-server/bin:$HOME/dev/nvim/marksman"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CUDA_HOME/lib64:$HOME/dev/nvim/nvim/lib"

# Npm env variables
export NPM_CONFIG_PREFIX=$HOME/.npm-global
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# Cargo source setup
source "$HOME/.cargo/env"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Start Tmux Session
if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
    tmux attach -t dev || tmux new -s dev
fi
