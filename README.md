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

The nvim config uses [lazy.nvim](https://github.com/folke/lazy.nvim) and targets Neovim **0.12+**.

Layout:

```
~/.config/nvim/
  init.lua
  lua/config/      -- options, keymaps, autocmds, lazy bootstrap
  lua/plugins/     -- one file per plugin spec
  legacy/          -- previous init.vim + lua/* (kept for reference)
```

The previous `~/.vimrc` and `init.vim` remain in `legacy/` and at the repo root for backup. Plugins are installed automatically by lazy.nvim on first launch.

### Plugin highlights

- **Colorscheme:** [qozymandias/NeoSolarized.nvim](https://github.com/qozymandias/NeoSolarized.nvim) (personal fork with custom palette)
- **Completion:** `saghen/blink.cmp` (cmdline auto-show enabled)
- **LSP:** `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim` (Rust handled exclusively by `mrcjkb/rustaceanvim`)
- **Treesitter:** `nvim-treesitter` `main` branch (required for nvim 0.12) - parsers compiled via `tree-sitter` CLI
- **File explorer:** `folke/snacks.nvim` `explorer` (sidebar, `<leader>e` to focus, `<leader>fe` to toggle, `<leader>fE` to reveal current)
- **Floating explorer:** `stevearc/oil.nvim` (`<leader>oe`)
- **Picker:** `telescope.nvim` (rounded borders, gd/gi/gr LSP keymaps)
- **Git:** `gitsigns.nvim` + `vim-fugitive`
- **DAP:** `nvim-dap` + `nvim-dap-ui` + `rustaceanvim`
- **UI:** `lualine.nvim`, `bufferline.nvim`, `dropbar.nvim`, `fidget.nvim`, `treesitter-context`

## Quick Setup

- **1.** Install [nvim](https://github.com/neovim/neovim/releases/tag/v0.12.2) (`>=0.12.2` required for treesitter `main` branch):

  ```bash
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install wget
    NVIM_TAR="nvim-macos-arm64"
  else
    sudo apt install wget
    NVIM_TAR="nvim-linux-x86_64"
  fi

  mkdir -p $HOME/dev/nvim
  cd $HOME/dev/nvim
  wget https://github.com/neovim/neovim/releases/download/v0.12.2/$NVIM_TAR.tar.gz
  tar xvf $NVIM_TAR.tar.gz
  mv $NVIM_TAR nvim
  ```

  Add `$HOME/dev/nvim/nvim/bin` to your `PATH`.

- **2.** Install deps:

  ```bash
  mkdir -p $HOME/.cache/nvim/
  touch $HOME/.npm-global

  if [[ "$(uname)" == "Darwin" ]]; then
    brew update && brew upgrade
    brew install python node npm ripgrep pkg-config openssl cmake llvm ninja shellcheck jq git-lfs \
        shfmt fd bash-completion@2 binutils tree-sitter tree-sitter-cli
  else
    sudo apt update && sudo apt upgrade -y
    sudo apt install python3 python3-pip python3-venv nodejs npm ripgrep pkg-config libssl-dev cmake \
        libclang-dev ninja-build shellcheck jq black shfmt git-lfs bash-completion@2 -y
    # tree-sitter CLI (required by nvim-treesitter main branch)
    npm install -g tree-sitter-cli
  fi

  python3 -m venv ~/.venvs/pynvim
  source ~/.venvs/pynvim/bin/activate
  pip install pynvim

  if [[ "$(uname)" == "Darwin" ]]; then
    pip install black
  fi

  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  npm install -g neovim typescript prettier doctoc

  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
  ```

  > Homebrew note: the `tree-sitter` formula only ships the C library; the CLI used by
  > nvim-treesitter `main` is the separate `tree-sitter-cli` formula.

- **3.** Copy the config files into your home directory:

  ```bash
  cd ~/dev/dotfiles
  cp .bashrc .bash_functions .bash_aliases .tmux.conf $HOME/
  cp -r .config/nvim $HOME/.config/
  ```

  > Note: the shell environment is currently still bash. Migration to zsh is a work in progress.

- **4.** Start `nvim`. lazy.nvim bootstraps and installs all plugins on first launch. Mason auto-installs the LSP servers listed in `lua/plugins/lsp.lua`. Treesitter parsers compile on first use.

- **5.** Verify everything is healthy:

  ```
  :Lazy
  :Mason
  :checkhealth
  ```

## Extras

### Alacritty Setup

#### WSL

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

#### Macos

```bash
# Install via homebrew
brew install --cask alacritty

# Copy config file
mkdir -p $HOME/.config/alacritty
cd ~/dev/dotfiles
cp alacritty.toml $HOME/.config/alacritty/alacritty.toml
```

### Locales fix

```bash
sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales
```

### SSH config file

Update `$HOME/.ssh/config` with identity file config:

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

### Install Nerd Fonts

#### WSL

Install via download [here](https://www.nerdfonts.com/font-downloads).
Extract and select all .ttf or .otf files, right-click and click install for all users.

#### Macos

```bash
brew install --cask font-fira-code-nerd-font
```

### Bash backup with cron


Run 
```
(crontab -l 2>/dev/null; echo "0 2 * * * /Users/downingo/dev/dotfiles/.backup_bash_history.sh") | crontab -
```

### Scan bash history backups for secrets

Interactively scan the weekly backup logs for likely sensitive data (AWS / GitHub / Slack / Google
keys, JWTs, PEM private key headers, URLs with embedded credentials, bearer tokens, and
`key=value` style assignments such as `password=`, `secret=`, `token=`, `api_key=`). For each match
the script prints the file, line number, matched substring and full line context, then asks whether
to replace the match with `[REDACTED]`.

```
./.scan_bash_history.sh                       # scan default backup dir
./.scan_bash_history.sh /path/to/other/dir    # scan a different dir
```

Answer `y` to redact, `n` (or Enter) to skip, `q` to quit.
