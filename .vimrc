"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Description: Vim configuration file  
" Author: Oscar Downing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'fannheyward/telescope-coc.nvim'
    " Plug 'ludovicchabant/vim-gutentags', {'branch': 'master'}
    Plug 'BurntSushi/ripgrep'
    Plug 'rhysd/vim-clang-format'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " Plug 'gfeiyou/command-center.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'mhinz/vim-signify'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    Plug 'EthanJWright/vs-tasks.nvim'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'jnurmine/Zenburn'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-fugitive'
    " Plug 'jaxbot/semantic-highlight.vim'
    " Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'AckslD/nvim-neoclip.lua'
    Plug 'tami5/sqlite.lua'
    Plug 'puremourning/vimspector'
    Plug 'neovim/pynvim'
    Plug 'nvim-telescope/telescope-vimspector.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    Plug 'sumneko/lua-language-server', { 'do' : 'make' }
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'tom-anders/telescope-vim-bookmarks.nvim'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'startup-nvim/startup.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'SmiteshP/nvim-gps'
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'vijaymarupudi/nvim-fzf'
    Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'nvim-telescope/telescope-smart-history.nvim'
    Plug 'nvim-telescope/telescope-frecency.nvim'
    Plug 'williamboman/nvim-lsp-installer'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:zenburn_high_Contrast = 1
let g:zenburn_italic_Comment=1
let g:zenburn_alternate_Visual = 1
colorscheme zenburn

" set background=dark
" colorscheme solarized
set completeopt=menu,menuone,noselect

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
set pastetoggle=<F12>   

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Save position on exit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.md 0r ~/.vim/templates/skeleton.md
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
    autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c
    autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
    autocmd BufNewFile *.h 0r ~/.vim/templates/skeleton.h
    autocmd BufNewFile *.java 0r ~/.vim/templates/skeleton.java
    autocmd BufNewFile *.kt 0r ~/.vim/templates/skeleton.kt
    autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
  augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
" Cogent syntax plugin
au BufNewFile,BufRead *.cogent so $VIM_FILES/cogent.vim
au BufNewFile,BufRead *.thy so $VIM_FILES/isabelle.vim
autocmd BufEnter *.ac :setlocal filetype=c
autocmd BufEnter *.hsc :setlocal filetype=haskell
autocmd BufEnter *.pbt :setlocal filetype=haskell
autocmd BufEnter xmobarrc :setlocal filetype=haskell
" LaTeX syntax fix
au BufRead,BufNewFile *.tex,*.sty,*.cls set filetype=tex
au FileType tex syntax on
au filetype tex syntax region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 tab == 4 spaces
set tabstop=4           
set shiftwidth=4 
" Use spaces instead of tabs 
set expandtab           
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => My Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <c-u> <NOP>
nnoremap <Space> <NOP>
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
vnoremap <C-c> "+y
map <C-p> "+P
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

set foldmethod=manual

nnoremap <leader>f} zfa}
nnoremap <leader>fc zd

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" missing ZZ and ZQ counterparts:
" quick save-buffer and quit-everything
nnoremap ZS :w<CR>
nnoremap ZX :qa<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rnu
" Pressing ,ss will toggle and untoggle spell checking
map <leader>1 :setlocal spell! spelllang=en_au<cr>
map <leader>2 :set rnu!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! s:VisualVLine() abort
    let [_, lnum, col; _] = getcurpos()
    let line = getline('.')
    let col += strdisplaywidth(line) - strwidth(line)

    let [from, to] = [lnum, lnum]
    while strdisplaywidth(getline(from - 1)) >= col
        let from -= 1
    endwhile

    while strdisplaywidth(getline(to + 1)) >= col
        let to += 1
    endwhile

    return "\<C-v>" .
                \ (to == lnum ? '' : (to - lnum . 'jo')) .
                \ (from == lnum ? '' : (lnum - from . 'k'))
endfun

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

func! AddToWatch()
    let word = expand("<cexpr>")
    call vimspector#AddWatch(word)
endfunction

" janko/vim-test and puremouring/vimspector integration
" function! JestStrategy(cmd)
"     let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
"     call vimspector#LaunchWithSettings( {'configuration': 'jest', 'TestName': testName} )
" endfunction

function InsertIfEmpty()
    if @% == ""
        " No filename for current buffer
        "startinsert
        Telescope vim_bookmarks
    elseif filereadable(@%) == 0
        " File doesn't exist yet
        startinsert
    elseif line('$') == 1 && col('$') == 1
        " File is empty
        startinsert
    endif
endfunction

au VimEnter * call InsertIfEmpty()

" autocmd VimEnter * :call BookmarkShowAll()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions usages 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use vm to highlight a 'slice' with visual mode
nnoremap <expr> vm <SID>VisualVLine()

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|TODO|OPTIMIZE|XXX|todo)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pmenu for autocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <CR>: confirm completion, or insert <CR>
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

highlight Pmenu guibg=gray
" ctermbg=gray 

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
" => Window
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Resize windows
"nnoremap <leader>+ :resize +2<cr>
"nnoremap <leader>= :resize -2<cr>
"nnoremap <leader>_ :vertical resize +2<cr>
"nnoremap <leader>- :vertical resize -2<cr>
nnoremap <Up>    :resize +3<CR>
nnoremap <Down>  :resize -3<CR>
nnoremap <Left>  :vertical resize -3<CR>
nnoremap <Right> :vertical resize +3<CR>
" nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

set splitbelow
set splitright

" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_new_list_item_indent = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Required for operations modifying multiple buffers like rename.
set hidden
autocmd BufReadPost *.kt setlocal filetype=kotlin

tnoremap <Esc> <C-\><C-n>

set tags=./tags;/
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

xnoremap < <gv
xnoremap > >gv

set matchpairs+=<:>

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format_git_diff = 1
let g:clang_format#auto_format_git_diff_fallback = 0
" let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#enable_fallback_style = 0
" let g:lsp_cxx_hl_use_text_props = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

nmap <Leader>B :lua require("telescope").extensions.vstask.tasks()<CR>
"nnoremap <Leader>ti :lua require("telescope").extensions.vstask.inputs()<CR>
"nnoremap <Leader>tt :lua require("telescope").extensions.vstask.close()<CR>

nnoremap <leader>hh :Telescope search_history<cr>
nnoremap <leader>h/ :Telescope resume<cr>
nnoremap <leader>h// :Telescope pickers<cr>
nnoremap <leader>y :Telescope neoclip<cr>

" Pick from all bookmarks
nnoremap <leader>b :Telescope vim_bookmarks all<cr>
" Only pick from bookmarks in current file
nnoremap <leader>bc :Telescope vim_bookmarks current_file<cr>

nnoremap <leader>c :Telescope command_history<cr>
nnoremap <leader>m :Telescope keymaps<cr>
nnoremap <leader>? :Telescope find_files<cr>
nnoremap <leader>/ :Telescope live_grep<cr> 
nnoremap <leader>e :NvimTreeToggle<cr>
" --smart-case<cr>
nnoremap <leader>r :Telescope registers<cr>
nnoremap <leader>gt :Telescope git_status<cr>
nnoremap <leader>gm :Git mergetool<cr>
" nnoremap <leader>s :SemanticHighlightToggle<cr>

nmap <leader>t :tab split<cr>
nmap <leader>tt :ToggleTerm direction=tab<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @todo have coc installs within vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Coc extensions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:coc_global_extensions = ['coc-word',
"             \ 'coc-explorer',
"             \ 'coc-dictionary',
"             \ 'coc-python',
"             \ 'coc-pyright',
"             \ 'coc-json',
"             \ 'coc-vimlsp',
"             \ 'coc-sumneko-lua',
"             \ 'coc-snippets',
"             \ 'coc-ccls' ]
" 
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" 
" " inoremap <silent><expr> <tab>
" "     \ pumvisible() ? "\<C-n>" :
" "     \ <SID>check_back_space() ? "\<tab>" :
" "     \ coc#refresh()
"  inoremap <silent><expr> <TAB>
"        \ pumvisible() ? "\<C-n>" : 
"        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ coc#refresh()
"  let g:coc_snippet_next = '<tab>'
" 
" " GoTo code navigation.
" nmap <silent> gd :Telescope coc definitions<cr>
" " nmap <silent> gD :tabedit % | Telescope coc definitions<cr>
" nmap <silent> gy :Telescope coc type_definitions<cr>
" nmap <silent> gi :Telescope coc implementations<cr>
" nmap <silent> gr :Telescope coc references<cr>
" nmap <silent> gu :Telescope coc references_used<cr>
" nmap <leader>f <Plug>(coc-fix-current)

nmap <silent> gd :Telescope lsp_definitions<cr>
nmap <silent> gi :Telescope lsp_implementations<cr>
nmap <silent> gr :Telescope lsp_references<cr>
" nmap <silent> gD :Telescope lsp_definitions<cr>
" nmap <silent> gy :Telescope lsp_type_definitions<cr>
" nmap <silent> gu :Telescope lsp_references_used<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Vimspector
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_enable_mappings = 'HUMAN'
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'vscode-node-debug2']

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
nnoremap <leader>dr :call vimspector#Restart()<CR>
nnoremap <leader>drr :call vimspector#Reset()<CR>

" key mapping for step into, next, finish until, continue
nnoremap <leader>dst :call vimspector#StepInto()<CR>
nnoremap <leader>dso :call vimspector#StepOver()<CR>
nnoremap <leader>dsu :call vimspector#StepOut()<CR>
nnoremap <leader>drh :call vimspector#RunToCursor()<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>

nnoremap <leader>ds :Telescope vimspector configurations<cr>

" up or down a frame
nnoremap <leader>u :call vimspector#UpFrame()<CR>
nnoremap <leader>d :call vimspector#DownFrame()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Lua
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lua require('telescope').load_extension('coc')
lua require('telescope').load_extension('neoclip')
lua require('telescope').load_extension('vimspector')
lua require('telescope').load_extension('file_browser')
lua require('telescope').load_extension('vim_bookmarks')
lua require('telescope').load_extension('fzy_native')
lua require('telescope').load_extension('smart_history')
lua require("nvim-gps").setup()

luafile /home/centos/.config/nvim/lua/telescope.lua
luafile /home/centos/.config/nvim/lua/neoclip.lua
luafile /home/centos/.config/nvim/lua/startup.lua
" luafile /home/centos/.config/nvim/lua/hardline.lua
luafile /home/centos/.config/nvim/lua/bufferline.lua
luafile /home/centos/.config/nvim/lua/nvim-tree.lua
luafile /home/centos/.config/nvim/lua/nvim-treesitter.lua
" luafile /home/centos/.config/nvim/lua/lsp-status.lua
luafile /home/centos/.config/nvim/lua/nvim-lsp-installer.lua
luafile /home/centos/.config/nvim/lua/lspconfig.lua
luafile /home/centos/.config/nvim/lua/lualine.lua
