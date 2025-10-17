"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Description: Vim configuration file  
" Author: Oscar Downing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'ishan9299/nvim-solarized-lua'
    Plug 'neovim/nvim-lspconfig'
    Plug 'neovim/pynvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'mason-org/mason.nvim'
    Plug 'mason-org/mason-lspconfig.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'linrongbin16/lsp-progress.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-vimspector.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-frecency.nvim'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    Plug 'startup-nvim/startup.nvim'
    Plug 'EthanJWright/vs-tasks.nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
    Plug 'akinsho/toggleterm.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'puremourning/vimspector'
    Plug 'puuuuh/vimspector-rust'
    Plug 'mhinz/vim-signify'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'vijaymarupudi/nvim-fzf'
    Plug 'onsails/lspkind.nvim'
    Plug 'SmiteshP/nvim-navic'
    Plug 'folke/lsp-colors.nvim'
    Plug 'tom-anders/telescope-vim-bookmarks.nvim'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'nvimtools/none-ls.nvim'
    Plug 'gbprod/none-ls-shellcheck.nvim'
    " Plug 'kyazdani42/nvim-tree.lua'
    " Plug 'L3MON4D3/LuaSnip'
    " Plug 'saadparwaiz1/cmp_luasnip'
    " Plug 'echasnovski/mini.nvim'
    " Plug 'echasnovski/mini.map'
    " Plug 'mfussenegger/nvim-jdtls'
    " Plug 'nvim-telesope/telescope-smart-history.nvim'
    " Plug 'stefandtw/quickfix-reflector.vim'
    " Plug 'jnurmine/Zenburn'
    " Plug 'sumneko/lua-language-server', { 'do' : 'make' }
    " Plug 'rhysd/vim-clang-format'
    " Plug 'BurntSushi/ripgrep'
    " Plug 'altercation/vim-colors-solarized'
    " Plug 'AckslD/nvim-neoclip.lua'
    " Plug 'tami5/sqlite.lua'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:zenburn_italic_Comment=1
" let g:zenburn_alternate_Visual = 1
" colorscheme zenburn
" colorscheme solarized
set termguicolors
set background=light
colorscheme solarized-high

highlight BufferLineTabSelected    guibg=#fdf6e3 guifg=#586e75 gui=bold
highlight BufferLineIndicatorSelected guibg=#fdf6e3 guifg=#268bd2 gui=bold

set completeopt=menu,menuone,noselect

" highlight Pmenu guibg=#7f9f7f guifg=grey
highlight Pmenu guibg=LightYellow guifg=Magenta

" MiniMapNormal
"
highlight TreesitterContext guibg=white
" guifg=#222222 guibg=black
" ctermbg=gray 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Save position on exit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " augroup templates
  "   autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
  "   autocmd BufNewFile *.md 0r ~/.vim/templates/skeleton.md
  "   autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
  "   autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c
  "   autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
  "   autocmd BufNewFile *.h 0r ~/.vim/templates/skeleton.h
  "   autocmd BufNewFile *.java 0r ~/.vim/templates/skeleton.java
  "   autocmd BufNewFile *.kt 0r ~/.vim/templates/skeleton.kt
  "   autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
  " augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => History / Undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use persistent history.
if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undodir=/tmp/.vim-undo-dir
set undofile

" :earlier 1m
" :later 1m
" norm Iblah blah
" g/^@/m56

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> General 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrl-q twice 
" cdo s/ / /g
let laststatus=3
" Sets how many lines of history VIM has to remember
set history=5000        
" Enable filetype plugins
filetype plugin on      
filetype indent on
" set explicit line numbering
set number              
" toggle for recognising format from clipboard paste
" set pastetoggle=<F12>   

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
" Cogent syntax plugin
au BufNewFile,BufRead *.cogent so $VIM_FILES/cogent.vim
au BufNewFile,BufRead *.thy so $VIM_FILES/isabelle.vim
autocmd BufEnter *.ac :setlocal filetype=c
autocmd BufEnter *.cl :setlocal filetype=cuda
autocmd BufEnter *.hsc :setlocal filetype=haskell
autocmd BufEnter *.pbt :setlocal filetype=haskell
autocmd BufEnter xmobarrc :setlocal filetype=haskell
autocmd BufReadPost *.kt setlocal filetype=kotlin
" LaTeX syntax fix
au BufRead,BufNewFile *.tex,*.sty,*.cls set filetype=tex
" au FileType tex syntax on
au filetype tex syntax region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 tab == 4 spaces
set tabstop=4           
set shiftwidth=4 
" Use spaces instead of tabs 
set expandtab           
autocmd FileType javascript,typescript,typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab

" Be smart when using tabs ;)
set smarttab            
" Linebreak on 500 characters
set lbr                 
set tw=500
" Auto indent
" set noautoindent
set ai                  
" Smart indent
" set nosmartindent
set si                  
" set nosi
set cin
" Wrap lines
set wrap                
" '100 Marks will be remembered for the last 100 edited files. 
" <1000 Limits the number of lines saved for each register to 1000 lines. 
" s100 Registers with more than 100 KB of text are skipped. 
" h Disables search highlighting when Vim starts.
set viminfo='100,<1000,s100,h
" turn all tabs into spaces
retab                   

nmap <leader>t :tab split<cr>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set splitbelow
set splitright

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Window
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Resize windows
nnoremap <Up>    :resize +3<CR>
nnoremap <Down>  :resize -3<CR>
nnoremap <Left>  :vertical resize -3<CR>
nnoremap <Right> :vertical resize +3<CR>
" nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_new_list_item_indent = 0

nnoremap <C-tab> <C-w>w 
":call CheckInsertAndEsc()<cr>
"call CheckInsertAndEsc()<CR>
nnoremap <C-S-tab> <C-w>W 

":call CheckInsertAndEsc()<cr>
nnoremap <C-A-tab> <C-w>r

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" Always show current position
set ruler
" customise ruler 
let &rulerformat = '%50(b%n %{&ff} %{&ft}' .
            \ '%( %{len(getqflist()) ? ("q" . len(getqflist())) : ""}%)' .
            \ '%( %{search("\\s$", "cnw", 0, 200) ? "∙$" : ""}%)' .
            \ '%( %{exists("b:stl_fn") ? call(b:stl_fn) : ""}%)' .
            \ '%= L%l,%c%V %P %*%)'
" Height of the command bar
set cmdheight=2
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight for search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" Don't redraw while executing macros (good performance config)
set lazyredraw 
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Required for operations modifying multiple buffers like rename.
set hidden
tnoremap <Esc> <C-\><C-n>
" set tags=./tags;/
xnoremap < <gv
xnoremap > >gv
set matchpairs+=<:>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rnu
" Pressing ,ss will toggle and untoggle spell checking
map <leader>1 :setlocal spell! spelllang=en_au<cr>
map <leader>2 :set rnu!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => My Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <c-u> <NOP>
nnoremap <space> <NOP>
noremap Q gq<CR>

" set map leader (like ctrl key)
let mapleader = " "
" Fast saving
nmap <leader>w :w!<cr>
" Fast save and then quit
nmap <leader>wq :wq!<cr>
" fast quit
nmap <leader>q :q<cr>
" toggle line numbers
map <leader>nu :set nu!<cr>
" make move up/down based on 'visual' line (what you see)
noremap <leader>j gj
noremap <leader>k gk
" :W sudo saves the file 
command W w !sudo tee % > /dev/null
" make Y yank to end of line
nnoremap Y y$
" copy/paste externally
"vnoremap <C-c> "+y
"map <C-p> "+P

if has('macunix')
  vnoremap <C-c> ::w !pbcopy<CR><CR>
else
  vnoremap <C-c> ::w !clip.exe<CR><CR>
endif

" Highlight in search toggle shortcut
nnoremap <silent> <C-_> :set hlsearch!<cr>
" nnoremap <leader>_ :set hlsearch!<cr>
" paragraph jump up/down 
noremap <silent> <expr> <C-k> (line('.') - search('^\n.\+$', 'Wenb')) . 'kzv^'
noremap <silent> <expr> <C-j> (search('^\n.', 'Wen') - line('.')) . 'jzv^'
" command mode remap: start of line
cnoremap <C-A> <Home>
" command mode remap: end of line
cnoremap <C-E> <End>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

func! AddToWatch()
    let word = expand("<cexpr>")
    call vimspector#AddWatch(word)
endfunction

func! CheckInsertAndEsc()
    if mode() == 'i'
        <esc>
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|TODO|OPTIMIZE|XXX|todo)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Clang-Format
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format_git_diff = 1
let g:clang_format#auto_format_git_diff_fallback = 0
" let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#enable_fallback_style = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bookmarks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VS Tasks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>b :lua require("telescope").extensions.vstask.tasks()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Explore
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>e :Explore<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gm :Git mergetool<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>tt :ToggleTerm<cr>
nmap <leader>tg :Telescope diagnostics<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Vimspector
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_enable_mappings = 'HUMAN'
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'vscode-node-debug2']

let g:vimspector_sidebar_width = 5
let g:vimspector_bottombar_height = 5
let g:vimspector_code_minwidth = 95
let g:vimspector_terminal_maxwidth = 500
let g:vimspector_terminal_minwidth = 20
let g:vimspector_variables_display_mode = 'full'

" inspect variable under current cursor
" for normal mode - the word under the cursor
nmap <leader>de <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <leader>de <Plug>VimspectorBalloonEval
" toggle breakpoint
nnoremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
" Add expression under current cursor to watch list
nnoremap <leader>dw :call AddToWatch()<CR>
" debugger launch, reset stop restart and pause
nnoremap <leader>dl :call vimspector#Launch()<CR>
nnoremap <leader>dp :call vimspector#Pause()<CR>
nnoremap <leader>dk :call vimspector#Stop()<CR>
nnoremap <leader>drr :call vimspector#Restart()<CR>
nnoremap <leader>dr :call vimspector#Reset()<CR>
" key mapping for step into, next, finish until, continue
nnoremap <leader>dst :call vimspector#StepInto()<CR>
nnoremap <leader>dso :call vimspector#StepOver()<CR>
nnoremap <leader>dsu :call vimspector#StepOut()<CR>
nnoremap <leader>drh :call vimspector#RunToCursor()<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>
nnoremap <leader>ds :Telescope vimspector configurations<cr>
" up or down a frame
nnoremap <leader>du :call vimspector#UpFrame()<CR>
nnoremap <leader>dd :call vimspector#DownFrame()<CR>
nnoremap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Telescope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>hh :Telescope search_history<cr>
nnoremap <leader>h/ :Telescope resume<cr>
nnoremap <leader>h// :Telescope pickers<cr>
nnoremap <leader>y :Telescope neoclip<cr>
" Pick from all bookmarks
" nnoremap <leader>b :Telescope vim_bookmarks all<cr>
" Only pick from bookmarks in current file
nnoremap <leader>bc :Telescope vim_bookmarks current_file<cr>
nnoremap <leader>c :Telescope command_history<cr>
nnoremap <leader>m :Telescope keymaps<cr>
nnoremap <leader>? :Telescope find_files<cr>
nnoremap <leader>/ :Telescope live_grep<cr>
nnoremap <leader>r :Telescope registers<cr>
nnoremap <leader>gt :Telescope git_status<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> gd :Telescope lsp_definitions<cr>
nmap <silent> gi :Telescope lsp_implementations<cr>
nmap <silent> gr :Telescope lsp_references<cr>
" call <SID>show_documentation()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>fo :lua vim.lsp.buf.format()<CR>
nnoremap <leader>fm :ClangFormat<CR>
nnoremap <silent>K  :lua vim.lsp.buf.hover()<CR>
nnoremap <silent>gy :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent>gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <C-k>      :lua vim.lsp.buf.signature_help()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Save & Quiting extras
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" missing ZZ and ZQ counterparts:
" quick save-buffer and quit-everything
nnoremap ZS :w<CR>
nnoremap ZX :qa<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Folds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=manual
nnoremap <leader>f} zfa}
nnoremap <leader>fc zd
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
nnoremap <C-Z> <NOP>
nnoremap <C-S-Z> <nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set signcolumn=yes
set mouse=c

let g:python3_host_prog = expand("~/.venvs/pynvim/bin/python")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Lua
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('telescope').load_extension('vimspector')
lua require('telescope').load_extension('file_browser')
lua require('telescope').load_extension('vim_bookmarks')
lua require('telescope').load_extension('fzy_native')

luafile $HOME/.config/nvim/lua/telescope.lua
luafile $HOME/.config/nvim/lua/startup.lua
luafile $HOME/.config/nvim/lua/nvim-treesitter.lua
luafile $HOME/.config/nvim/lua/lspconfig.lua
luafile $HOME/.config/nvim/lua/vstask.lua
luafile $HOME/.config/nvim/lua/treesitter-context.lua
luafile $HOME/.config/nvim/lua/toggleterm.lua
luafile $HOME/.config/nvim/lua/lualine.lua
luafile $HOME/.config/nvim/lua/bufferline.lua
