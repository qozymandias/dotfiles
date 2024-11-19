
#alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
#alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
#alias copyboard='pbcopy'
#alias zshrc='vim ~/.zshrc'
#alias ip='ifconfig en0 | awk '/inet / {print $2}''
# netstat -rf inet | awk '/[a-z]+/ {print $1}'
# alias gtkwave='open -a gtkwave'
#  nmap -sP 172.27.37.0/24 | awk -F 'for' '{print $2}'
#alias ls='colorls --sd'
#alias lc='colorls --tree'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# !!! ALIASES !!!
# ---------------------------------------------------------------
alias ls='ls -F' #  --color=auto'
alias l='ls'
alias ll='ls -lh'
alias lt='ls --human-readable --size -1 -S --classify'
alias left='ls -t -1'
alias count='find . -type f | wc -l'
alias cs='clear;ls'
alias h='history'
alias gh='history|grep'
alias gt='git status --short'
alias grep='grep --color=auto'
alias cl='clear'
alias extract='tar xvf' 
alias ~='cd ~/'
alias cseVPN='sudo /usr/local/sbin/openvpn --config ~/vpn/cse.ovpn'
alias gitfetch='onefetch'
alias v='nvim'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias sens='vim ~/.sensitive.md'
alias note='nvim ~/notes/TODO.md'
alias dnote='nvim ~/notes/DAILY_TODO.md'
alias reflect='nvim ~/notes/REFLECTION.md'
alias quote='vim ~/notes/QUOTES.md'
alias goals='vim ~/notes/GOALS.md'
alias isabelle='/home/oscar/.Isabelle/Isabelle2020/Isabelle2020'
alias isabelle-cli='/home/oscar/.Isabelle/Isabelle2020/bin/isabelle'
# py virtual env
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'
# copy with progress indicator
alias cpv='rsync -ah --info=progress2'
# safe remove
alias trash='mv --force -t ~/.local/share/Trash '
alias cd1='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
alias cd6='cd ../../../../../..'
alias cd7='cd ../../../../../../..'
alias cd8='cd ../../../../../../../..'
alias cd9='cd ../../../../../../../../..'
alias cd10='cd ../../../../../../../../../..'
alias cd11='cd ../../../../../../../../../../..'
alias cd12='cd ../../../../../../../../../../../..'
alias cd13='cd ../../../../../../../../../../../../..'
alias cd14='cd ../../../../../../../../../../../../../..'
alias cd15='cd ../../../../../../../../../../../../../../..'

alias fixaudio='systemctl --user restart pulseaudio.service'
alias viewcpu='watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""'
alias fixblue='sudo service bluetooth restart'

alias changefont='nvim ~/.config/qterminal.org/qterminal.ini'
alias fixtime='sudo ntpd -g'
alias soundmenu='pavucontrol'
alias whatsenabled='systemctl list-unit-files --state=enabled'
alias whatsrunning='systemctl list-units --type=service --state=running'
alias startssh='sudo systemctl start sshd'
alias cdproj='cd ~/Documents/Gitlab/dvcs/Project'
alias cdcipipeline='cd ~/dev/dvcs'
alias clswaps='rm ~/.local/share/nvim/swap/*.swp'

alias fixaudio='sudo killall coreaudiod && sudo launchctl start com.apple.audio.coreaudiod'
alias vup='vagrant up'
alias vlt='vagrant halt'
alias vsh='vagrant ssh'
alias vgt='vagrant global-status'
alias cdvagrantmain='cd ~/dev/dolby/vagrant/centos7'
alias cdvagrantside='cd ~/dev/dolby/virtual/vagrant/centos7'
alias showmem='lshw -c memory'
alias synczkp='rsync -avz --exclude "auto_submit_workspace/" --exclude "workplace/" --exclude "server_storage/" --exclude ".git/" --exclude "target/" --exclude "node_modules/" -e "ssh -i ~/.ssh/id_ed25519" ~/dev/zkp/restservice/zkp/ oscar@138.217.142.94:~/fresh/restservice/zkp'
alias gd='git diff'
alias showbig='du -h --max-depth=1 | sort -hr'
