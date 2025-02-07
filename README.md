```
 _(`-')               (`-')                   _                 (`-')  _  (`-').-> 
( (OO ).->      .->   ( OO).->      <-.      (_)        <-.     ( OO).-/  ( OO)_   
 \    .'_  (`-')----. /    '._   (`-')-----. ,-(`-')  ,--. )   (,------. (_)--\_)  
 '`'-..__) ( OO).-.  '|'--...__) (OO|(_\---' | ( OO)  |  (`-')  |  .---' /    _ /  
 |  |  ' | ( _) | |  |`--.  .--'  / |  '--.  |  |  )  |  |OO ) (|  '--.  \_..`--.  
 |  |  / :  \|  |)|  |   |  |     \_)  .--' (|  |_/  (|  '__ |  |  .--'  .-._)   \ 
 |  '-'  /   '  '-'  '   |  |      `|  |_)   |  |'->  |     |'  |  `---. \       / 
 `------'     `-----'    `--'       `--'     `--'     `-----'   `------'  `-----'  
```
# Neovim dev env setup 
Note: Due to not wanting to convert my vimrc into lua file, nvim config file (`~/.config/nvim/init.lua`) actually calls `vimrc`. 

## Quick Setup
1) Install [nvim](https://github.com/neovim/neovim/releases) (greater than `0.9`):
```
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar xvf nvim-linux64.tar.gz
cd nvim-linux64
```
Either, update your `$PATH` and `$LD_LIBRARY_PATH`:
```
# e.g.
export PATH="$PATH:/home/oscar/nvim-linux64/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/oscar/nvim-linux64/lib"
```
Or, copy in `/usr` paths (requires sudo):
```
# e.g.
sudo cp bin/nvim /usr/bin/
sudo cp -r lib/* /usr/lib/

sudo rm -rf /usr/share/nvim/runtime
sudo cp -r share/nvim/runtime /usr/share/nvim/
```

2) Install [vim-plug](https://github.com/junegunn/vim-plug):
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

3) Install [pynvim](https://github.com/neovim/pynvim) (required for some plugins):
```
pip3 install pynvim
```

4) Copy the config files in your home directory:
```
cp .vimrc ~/.vimrc
cp -r .config/nvim ~/.config/
```

5) Install plugins and LSP (you can also run this normally with nvim cmd line):
```
nvim --headless +PlugInstall +TSUpdate +qa;
```

6) Your done! 
```
nvim
```
Run healthcheck and follow any install recommendations:
```
:checkhealth
```
