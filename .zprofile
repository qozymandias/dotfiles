# ~/.zprofile
# Load .zshrc for interactive settings even in login shells (zsh sources
# .zprofile for login shells before .zshrc, so just defer to .zshrc here).
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

alias assume=". assume"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
