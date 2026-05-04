# ~/.bash_profile
# Load bashrc for interactive settings even in login shells
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
. "$HOME/.cargo/env"

alias assume=". assume"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
