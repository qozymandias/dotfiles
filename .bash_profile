# ~/.bash_profile
# Load bashrc for interactive settings even in login shells
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
. "$HOME/.cargo/env"

alias assume=". assume"

# . "$HOME/.atuin/bin/env"

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
