#/bin/bash

rsync -av --exclude '*plugged*' --exclude '*cppman*' ~/.vim* ~/.config ~/.bash* ~/Documents/Gitlab/dvcs/Project/.vim* ~/Documents/Gitlab/dvcs/Project/.vscode ./
