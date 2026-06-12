-- Core Neovim options (translated from the previous .vimrc).

local opt = vim.opt
local g = vim.g

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = vim.fn.expand("~/.venvs/pynvim/bin/python")

opt.termguicolors = true
opt.background = "light"
opt.completeopt = { "menu", "menuone", "noselect" }

opt.history = 5000
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.mouse = "c"
opt.laststatus = 3
opt.cmdheight = 2
opt.so = 7
opt.ruler = true
opt.wildmenu = true
opt.wildignore = { "*.o", "*~", "*.pyc", "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store" }

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.linebreak = true
opt.textwidth = 500
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.wrap = false
opt.splitbelow = true
opt.splitright = true

opt.hidden = true
opt.backspace = { "eol", "start", "indent" }
opt.whichwrap:append("<,>,h,l")
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.magic = true
opt.showmatch = true
opt.matchtime = 2
opt.errorbells = false
opt.visualbell = false
opt.timeoutlen = 500
opt.matchpairs:append("<:>")
opt.winborder = "rounded"

opt.fixeol = true
opt.fileformat = "unix"
opt.foldmethod = "manual"

opt.sidescrolloff = 36
opt.shada = { "'100", "<1000", "s100", "h" }

local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p", tonumber("700", 8))
end
opt.undodir = undodir
opt.undofile = true
