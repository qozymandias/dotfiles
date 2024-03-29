# ~/.bashrc: executed by bash(1) for non-login shells.

# !!! EXPORTS !!!
# ---------------------------------------------------------------
export VIM_FILES="~/.vim"
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# !!! PROMPT !!!
# ---------------------------------------------------------------
if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \n--> '
#\`nonzero_return\`
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[00m\]@\[\033[01;31m\]\h\[\033[00m\]:\[\033[03;34m\]\w\[\033[00m\] \[\033[35;4m\]\`parse_git_branch\`\[\033[00m\] \[\033[93;1m\][\T]\[\033[00m\]\n--> "
else
    PS0='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# !!! bash completion !!!
# ---------------------------------------------------------------
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# !!! alias definitions !!!
# ---------------------------------------------------------------
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

# !!! function definitions !!!
# ---------------------------------------------------------------
if [ -e $HOME/.bash_functions ]; then
    source $HOME/.bash_functions
fi

PATH=$PATH'/usr/bin/:/opt/rh/devtoolset-9/root/usr/bin/:/usr/libexec/gcc/x86_64-redhat-linux/4.8.5/'

# sudo /etc/init.d/bluetooth start

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/oscar/.sdkman"
#[[ -s "/home/oscar/.sdkman/bin/sdkman-init.sh" ]] && source "/home/oscar/.sdkman/bin/sdkman-init.sh"
# source /home/oscar/dev/uni/21T2/cs6771/labs/tut01/vcpkg/scripts/vcpkg_completion.bash

#source /opt/Xilinx/Vivado/2020.1/settings64.sh
#export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH

export LANG=en_GB.UTF-8
export BASH_SILENCE_DEPRECATION_WARNING=1
export ASAN_OPTIONS=detect_leaks=0
# export LSAN_OPTIONS=verbosity=1:log_threads=1
# export ASAN_OPTIONS=detect_leaks=0

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
