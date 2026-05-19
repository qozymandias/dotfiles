# ~/.zshrc

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=90000
SAVEHIST=90000
setopt EXTENDED_HISTORY        # write timestamps to histfile
setopt INC_APPEND_HISTORY      # write history as commands run, not at exit
setopt SHARE_HISTORY           # share history across concurrent shells
setopt HIST_IGNORE_DUPS        # don't record consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS    # remove older duplicate when adding new
setopt HIST_IGNORE_SPACE       # don't record commands starting with space
setopt HIST_FIND_NO_DUPS       # don't display duplicates while searching
setopt HIST_REDUCE_BLANKS      # collapse internal whitespace
setopt HIST_VERIFY             # show !-expansion before executing

# Directory navigation
setopt AUTO_CD                 # `dir` instead of `cd dir`
setopt AUTO_PUSHD              # cd pushes onto dir stack
setopt PUSHD_IGNORE_DUPS       # no duplicate stack entries
setopt PUSHD_SILENT            # quiet pushd / popd

# General behaviour
setopt EXTENDED_GLOB           # **/, ^, ~, etc.
setopt INTERACTIVE_COMMENTS    # allow `# comments` at the prompt
setopt NO_BEEP                 # quiet down
setopt PROMPT_SUBST            # allow command substitution in PROMPT

# Keep PATH and friends free of duplicates
typeset -U path PATH fpath manpath

# Homebrew zsh completions (must be on fpath BEFORE compinit)
if (( $+commands[brew] )); then
    BREW_PREFIX="$(brew --prefix)"
    fpath=("${BREW_PREFIX}/share/zsh-completions" "${BREW_PREFIX}/share/zsh/site-functions" $fpath)
fi

# Completion
autoload -Uz compinit
# Cache compinit's dump for 24h instead of regenerating every shell.
# (qN.mh+24) glob qualifier: "modified more than 24h ago"; if so, full compinit
# (which rebuilds the dump). Otherwise compinit -C skips the security audit and
# loads the cached dump straight away. Saves ~100ms on warm shells.
ZCOMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
[[ -d "${ZCOMPDUMP:h}" ]] || mkdir -p "${ZCOMPDUMP:h}"
if [[ -n ${ZCOMPDUMP}(#qN.mh+24) ]]; then
    compinit -i -d "$ZCOMPDUMP"
else
    compinit -C -d "$ZCOMPDUMP"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:warnings' format '%F{yellow}no matches for: %d%f'

# Alt-Backspace deletes one "segment" at a time. The built-in
# backward-kill-word respects $WORDCHARS, which by default includes "/" so a
# whole path gets eaten. Define a custom widget that treats only alnum + a few
# safe chars as word characters, making /, -, _, ., :, =, @ act as boundaries.
backward-kill-segment() {
    local WORDCHARS=''
    zle backward-kill-word
}
zle -N backward-kill-segment
# Alacritty / iTerm send Alt-Backspace as ESC + DEL (^[^?). Bind both that and
# the alternative ^W-style sequence so it works across terminals/tmux.
bindkey '^[^?' backward-kill-segment   # Alt-Backspace
bindkey '\e\b' backward-kill-segment   # same, alt encoding

# Source aliases / functions
[[ -f "$HOME/.zsh_aliases"   ]] && source "$HOME/.zsh_aliases"
[[ -f "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"

[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Git branch in prompt via Starship (replaces vcs_info; async, faster on large repos)
if (( $+commands[starship] )); then
    export STARSHIP_CONFIG="$HOME/.config/starship.toml"
    eval "$(starship init zsh)"
else
    # Fallback: zsh-native vcs_info if Starship is not installed.
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' formats       '[%b%u%c]'
    zstyle ':vcs_info:git:*' actionformats '[%b|%a%u%c]'
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' unstagedstr '!'
    zstyle ':vcs_info:*' stagedstr   '+'
    precmd_functions+=( vcs_info )
    PROMPT='%F{red}%n%f@%F{red}relx%f:%F{blue}%~%f %F{magenta}${vcs_info_msg_0_}%f %F{yellow}[%D{%H:%M:%S}]%f
--> '
fi

# Locale & compiler env
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export ASAN_OPTIONS=detect_leaks=0

# CUDA
export CUDA_HOME=/usr/local/cuda

# PATH (typeset -U above keeps these unique)
path=(
    /opt/homebrew/bin
    "$HOME/.npm-global/bin"
    "$HOME/dev/nvim/nvim/bin"
    "$HOME/dev/nvim/lua-language-server/bin"
    "$HOME/dev/nvim/marksman"
    "$CUDA_HOME/bin"
    $path
)
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}:$CUDA_HOME/lib64:$HOME/dev/nvim/nvim/lib"

export VIM_FILES="$HOME/.vim"
export NVIM_PYTHON_LOG_FILE="$HOME/.cache/nvim/nvim-python.log"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"

# Lazy-load nvm: sourcing nvm.sh costs ~300ms. Defer until you actually run
# nvm/node/npm/npx/yarn/pnpm/corepack. The first call pays the cost, every
# shell thereafter starts instantly.
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    _nvm_load() {
        unset -f nvm node npm npx yarn pnpm corepack _nvm_load
        source "$NVM_DIR/nvm.sh"
        [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    }
    nvm()      { _nvm_load; nvm      "$@"; }
    node()     { _nvm_load; node     "$@"; }
    npm()      { _nvm_load; npm      "$@"; }
    npx()      { _nvm_load; npx      "$@"; }
    yarn()     { _nvm_load; yarn     "$@"; }
    pnpm()     { _nvm_load; pnpm     "$@"; }
    corepack() { _nvm_load; corepack "$@"; }
fi

# Lazy-activate the pynvim venv only when python/pip is invoked.
if [[ -f "$HOME/.venvs/pynvim/bin/activate" ]]; then
    _pynvim_activate() {
        unset -f python python3 pip pip3 _pynvim_activate
        source "$HOME/.venvs/pynvim/bin/activate"
    }
    python()  { _pynvim_activate; command python  "$@"; }
    python3() { _pynvim_activate; command python3 "$@"; }
    pip()     { _pynvim_activate; command pip     "$@"; }
    pip3()    { _pynvim_activate; command pip3    "$@"; }
fi

# Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Tmux is launched by the terminal emulator (see alacritty.toml), not from .zshrc.
# Keeping it out of here means subshells / ssh / scripts don't get hijacked.

export RA_CACHE_DIR="$HOME/.cache/rust-analyzer"

ulimit -n 65536
