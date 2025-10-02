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

- **1.** Install [nvim](https://github.com/neovim/neovim/releases/tag/v0.11.3) (greater than `0.9`, recommended `0.11.3`):

  ```bash
  mkdir -p $HOME/dev/nvim
  cd $HOME/dev/nvim
  wget https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz
  tar xvf nvim-linux-x86_64.tar.gz
  ```

- **2.** Install [vim-plug](https://github.com/junegunn/vim-plug):

  ```bash
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

- **3.** Install deps:

  ```bash
  mkdir -p /home/oscar/.cache/nvim/
  touch /home/oscar/.cache/nvim/lsp-installer.log
  touch /home/oscar/.npm-global

  sudo apt update && sudo apt upgrade -y
  sudo apt install python3 python3-pip python3-venv nodejs npm ripgrep pkg-config libssl-dev cmake \
      libclang-dev ninja-build shellcheck jq black shfmt git-lfs -y

  python3 -m venv ~/.venvs/pynvim
  source ~/.venvs/pynvim/bin/activate
  pip install pynvim

  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  npm install -g neovim vim-language-server typescript-language-server typescript prettier doctoc

  mkdir -p $HOME/dev/nvim
  cd $HOME/dev/nvim
  git clone https://github.com/LuaLS/lua-language-server
  cd lua-language-server
  ./make.sh
  cd ..
  mkdir -p marksman
  cd marksman
  wget https://github.com/artempyanykh/marksman/releases/download/2024-12-18/marksman-linux-x64
  mv marksman-linux-x64 marksman
  chmod +x marksman
  ```

- **4.** Copy the config files in your home directory:

  ```bash
  cp .vimrc .bashrc .bash_functions .bash_aliases .tmux.conf $HOME/
  cp -r .config/nvim $HOME/.config/
  ```

- **5.** Start `nvim` and run the following commands:

  ```
  :PlugInstall
  :TSUpdate
  :TSInstall python vim json bash yaml html typescript tsx javascript html rust markdown lua
  ```

- **6.** Check health by running `healthcheck` command and following any install recommendations:
  ```
  :checkhealth
  ```

## Extras

### Alacritty Setup

For WSL [alacritty](https://alacritty.org/) with tmux is recommended. Copy [`alacritty.toml`](./alacritty.toml) in AppData directory.
This can be determined by running `alacritty -v` in powershell.

E.g.

```powershell
C:\Users\odown>alacritty -v

C:\Users\odown>Created log file at "C:\Users\odown\AppData\Local\Temp\Alacritty-27204.log"
[0.000008200s] [INFO ] [alacritty] Welcome to Alacritty
[0.000705600s] [INFO ] [alacritty] Version 0.15.1 (0c405d5)
[0.002281900s] [INFO ] [alacritty] Configuration files loaded from:
                                     "C:\\Users\\odown\\AppData\\Roaming\\alacritty\\alacritty.toml"
```

### Locales fix

```bash
sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales
```

### SSH config file

```bash
Host *
    AddKeysToAgent yes
    Compression yes
    IdentityFile ~/.ssh/id
```

### Rust specify

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo --version

rustup component add rust-analyzer clippy

# Set to project specific
rustup override set $(cat rust-toolchain)
```

### Cuda/Nvidia specific

Follow installation instructions [here](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local)

### Lsp config docs

Instructions [here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)

### Dioxus specific

```bash
cargo install dioxus-cli
```

```bash
sudo apt update
sudo apt install \
    libwebkit2gtk-4.1-dev build-essential libxdo-dev libayatana-appindicator3-dev  librsvg2-dev libglib2.0-dev \
    libgtk-3-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev libatk1.0-dev libgirepository1.0-dev pkg-config \
    libjavascriptcoregtk-4.1-dev libsoup-3.0-dev pkg-config
```

### Install Node Version Manager and Upgrade Node

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc

nvm install 22
nvm use 22

node -v
```
