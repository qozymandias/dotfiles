#!/bin/bash

HISTCONTROL=ignoreboth
HISTSIZE=90000
HISTFILESIZE=90000

shopt -s histappend
shopt -s checkwinsize

PS1="\[\033[01;31m\]\u\[\033[00m\]@\[\033[01;31m\]relx\[\033[00m\]:\[\033[03;34m\]\w\[\033[00m\] \[\033[35;4m\]\`parse_git_branch\`\[\033[00m\] \[\033[93;1m\][\T]\[\033[00m\]\n--> "

[ -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
[ -f "$HOME/.bash_functions" ] && source "$HOME/.bash_functions"
[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"

export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export LANG=en_GB.UTF-8
export ASAN_OPTIONS=detect_leaks=0
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
# CUDA env variables, see installation here https://developer.nvidia.com/cuda-downloads
export CUDA_HOME=/usr/local/cuda
export PATH="$PATH:$CUDA_HOME/bin:$HOME/dev/nvim/nvim/bin:$HOME/.npm-global/bin:$HOME/dev/nvim/lua-language-server/bin:$HOME/dev/nvim/marksman"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CUDA_HOME/lib64:$HOME/dev/nvim/nvim/lib"

export VIM_FILES="$HOME.vim"
export NVIM_PYTHON_LOG_FILE=$HOME/.cache/nvim/nvim-python.log

# Npm env variables
export NPM_CONFIG_PREFIX=$HOME/.npm-global
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export BASH_SILENCE_DEPRECATION_WARNING=1
source ~/.venvs/pynvim/bin/activate

# Cargo source setup
source "$HOME/.cargo/env"

# Start Tmux Session
if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
    tmux attach -t dev || tmux new -s dev
fi

export RA_CACHE_DIR="$HOME/.cache/rust-analyzer"


[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# export LIBCLANG_PATH=/opt/homebrew/opt/llvm/lib
# export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/opt/llvm/lib
# export AR=$(brew --prefix)/opt/binutils/bin/gar

ulimit -n 65536
