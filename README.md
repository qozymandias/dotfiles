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
- 1) Install [nvim](https://github.com/neovim/neovim/releases/tag/v0.10.4) (greater than `0.9`, recommended `0.10.4`):
    ```
    mkdir -p dev/nvim
    cd dev/nvim
    wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
    tar xvf nvim-linux-x86_64.tar.gz
    cd nvim-linux-x86_64
    ```

    Either, update your `$PATH` and `$LD_LIBRARY_PATH`:
    ```
    # e.g.
    export PATH="$PATH:/home/oscar/dev/nvim/nvim-linux-x86_64/bin"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/oscar/dev/nvim/nvim-linux-x86_64/lib"
    ```

    Or, copy in `/usr` paths (requires sudo):
    ```
    # e.g.
    sudo cp bin/nvim /usr/bin/
    sudo cp -r lib/* /usr/lib/

    sudo rm -rf /usr/share/nvim/runtime
    sudo cp -r share/nvim/runtime /usr/share/nvim/
    ```

- 2) Install [vim-plug](https://github.com/junegunn/vim-plug):
    ```
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

- 3) Install deps:
    ```
    mkdir -p /home/oscar/.cache/nvim/
    touch /home/oscar/.cache/nvim/lsp-installer.log
    touch /home/oscar/.npm-global

    sudo apt update && sudo apt upgrade -y
    sudo apt install python3 python3-pip python3-venv nodejs npm ripgrep pkg-config libssl-dev cmake libclang-dev -y

    python3 -m venv ~/.venvs/pynvim
    source ~/.venvs/pynvim/bin/activate
    pip install pynvim

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    npm install -g neovim vim-language-server
    ```

- 4) Copy the config files in your home directory:
    ```
    cp .bashrc ~/
    cp .bash_functions ~/
    cp .bash_aliases ~/
    cp .vimrc ~/
    cp -r .config/nvim ~/.config/
    ```

- 5) Start nvim and install vim-plug and update TS
    ```
    nvim 
    ```

    ```
    :PlugInstall 
    :TSUpdate
    :TSInstall python vim json bash yaml html typescript tsx javascript html rust markdown
    ```

    - 6) Check health
    ```
    nvim
    ```

    Run healthcheck and follow any install recommendations:
    ```
    :checkhealth
    ```

## Locales fix

```
sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales
```

## SSH config file

```
Host *
    AddKeysToAgent yes
    Compression yes
    IdentityFile ~/.ssh/id
```

## Rust specify

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo --version

rustup component add rust-analyzer
rustup component add clippy

# Set to project specific
rustup override set $(cat rust-toolchain)
```

## Cuda/Nvidia specific

Follow installation instructions: [here](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local)
