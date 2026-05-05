# ~/.zshrc

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=90000
SAVEHIST=90000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Window resize handling - zsh handles checkwinsize automatically.

# Completion
autoload -Uz compinit
compinit -u

# Allow command substitution in prompt
setopt PROMPT_SUBST

# Source aliases / functions
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"
[ -f "$HOME/.zsh_functions" ] && source "$HOME/.zsh_functions"

# Homebrew zsh completions (if installed)
if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX="$(brew --prefix)"
    fpath=("${BREW_PREFIX}/share/zsh-completions" "${BREW_PREFIX}/share/zsh/site-functions" $fpath)
fi

# fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Prompt: user@relx:cwd [git] [time]
PROMPT='%F{red}%n%f@%F{red}relx%f:%F{blue}%~%f %F{magenta}$(parse_git_branch)%f %F{yellow}[%D{%H:%M:%S}]%f
--> '

export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export ASAN_OPTIONS=detect_leaks=0

# CUDA env variables, see https://developer.nvidia.com/cuda-downloads
export CUDA_HOME=/usr/local/cuda
export PATH="$PATH:$CUDA_HOME/bin:$HOME/dev/nvim/nvim/bin:$HOME/.npm-global/bin:$HOME/dev/nvim/lua-language-server/bin:$HOME/dev/nvim/marksman"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}:$CUDA_HOME/lib64:$HOME/dev/nvim/nvim/lib"

export VIM_FILES="$HOME/.vim"
export NVIM_PYTHON_LOG_FILE="$HOME/.cache/nvim/nvim-python.log"

# Npm env variables
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pynvim virtualenv
[ -f "$HOME/.venvs/pynvim/bin/activate" ] && source "$HOME/.venvs/pynvim/bin/activate"

# Cargo
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Start tmux on interactive shells
if [[ -o interactive ]] && [ -z "${TMUX:-}" ]; then
    tmux attach -t dev || tmux new -s dev
fi

export RA_CACHE_DIR="$HOME/.cache/rust-analyzer"

ulimit -n 65536
