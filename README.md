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

## Dependancies
- [neovim](https://github.com/neovim/neovim)
- [neovim python package](https://pypi.org/project/neovim)
- [vim-plug](https://github.com/junegunn/vim-plug)

## Quick Setup
1) Copy the config files in your home directory.
```
cp .vimrc ~/.vimrc
cp -r .config/nvim ~/.config/
```

2) Install plugins and LSP (you can also run this normally with nvim cmd line)
```
nvim --headless +PlugInstall +TSUpdate +qa;
```

3) Your done! 
```
nvim
```

Run healthcheck
```
:checkhealth
```
