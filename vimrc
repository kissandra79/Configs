" First install and run this -> git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" Run BundleUpdate
" goto ~/.vim/bundles/vimproc.vim
" Run make

"necessary for lots of cool vim things
set nocompatible
filetype off
filetype plugin off
filetype plugin indent off

"map leader
let mapleader = ","

"vundle vim plugin manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"my bundles
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'thinca/vim-unite-history'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'

"trim trailing spaces
function! TrimTrailingWhitespace()
    execute "normal mz"
    %s/\s\+$//ge
    execute "normal `z"
endfunction

if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    "automatically reload vimrc when it is saved
    autocmd BufWritePost .vimrc source ~/.vimrc
    "remove any trailing whitespace in the file
    autocmd BufWrite * :call TrimTrailingWhitespace()
    "jump to last position when opening file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    "do not show matching parenthesis
    autocmd VimEnter * NoMatchParen
endif

"general Settings
syntax enable
syntax on
filetype on
filetype plugin on
filetype plugin indent on

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"tell the term has 256 colors
set t_Co=256

"line numbers
set number

"block edit in visual mode
set virtualedit=block

set nowrap
"set wrap "wrap lines
"set linebreak "wrap lines at convenient points

"mark the ideal max text width
"set colorcolumn=+1

"indent settings
set shiftwidth=4 "no of spaces for autoindent
set softtabstop=4
"set tabstop=4
set expandtab    "expand tabs to spaces
set autoindent
set copyindent   "copy previous indentation on autoindenting
set shiftround   "use multiple of shiftwidth when indenting
set nojoinspaces "don't convert spaces to tabs
set smarttab     "indent instead of tab at start of line
"set linespace=0 "sets linespace (px between lines)

"configure wild menu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.py[co],*.obj,*.bak
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"dont continue comments when pushing o/O
set formatoptions-=o

"enable mouse support in console
set mouse=a

"autoread files changed outside vim
set autoread

set hidden "allow buffers to exist in the background even if it is not in Window

set showcmd "display command in lower right corner
set noshowmode

set laststatus=2 "use 2 lines for status bar

"searching
set ignorecase "case insenstive while searching
set smartcase  "case sensitive if search pattern contains uppercase characters
set hlsearch   "highlight search words
set incsearch  "incremental searching

"set clipboard=unnamedplus "use the OS clipboard by default
set clipboard=unnamed

set nobackup "do we need backups
set noswapfile
set nowb

"save folds on quit
set foldmethod=marker

"vertical/horizontal scroll off settings
set scrolloff=3     "minimal number of lines to keep above and below cursor
set sidescrolloff=3 "minimal number of lines to keep to the left and right of cursor
set sidescroll=1
"set scrolljump=5

"Lower delay of escaping out of other modes
set timeout timeoutlen=1000 ttimeoutlen=0

"Change color of line numbers
highlight LineNr ctermfg=blue ctermbg=black

" Horizontal scroll jump
nnoremap L 10zl
nnoremap H 10zh

" indent and keep selection so that i can do it again
vnoremap < <gv
vnoremap > >gv

" Remap jk to escape from insert mode.
inoremap jk <Esc>

" Edit vimrc file
nnoremap  <Leader>ev :e ~/.vimrc<CR>

" Clear highlighted text
nnoremap <leader>s :noh<CR>

" Buffer settings
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

" Page down and Page up
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" Switch to previous edited buffer
nnoremap <C-b> :b#<CR>

" Navigating the lines
nnoremap J 3j
nnoremap K 3k
vnoremap J 3j
vnoremap K 3k

" Join lines
nnoremap ; J

" Visually show when I enter and leave `insert` mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" Toggle existing fold
nnoremap <Leader>a za
" Toggle existing folds recursively
nnoremap <Leader>A zA
" Open all folds
nnoremap <Leader>R zR
" Close all folds
nnoremap <Leader>M zM

" Search highlighted text
vnoremap / yq/p<CR>

"""""""""""""
"  PLUGINS  "
"""""""""""""

" Bufkill mappings. Allows to keeps windows open even when a buffer is deleted
cnoremap bd BD

" EasyMotion
let g:EasyMotion_do_mapping = 0
map f <Plug>(easymotion-s)
map ew <Plug>(easymotion-bd-w)
map er <Plug>(easymotion-bd-jk)

" Unite
let g:unite_prompt = '>>'
let g:unite_source_grep_default_opts   = "-iInH"
let g:unite_source_grep_recursive_opt  = "-r"
let g:unite_source_grep_max_candidates = 200
let g:unite_source_history_yank_enable = 1
let g:unite_source_buffer_time_format  = ""
nnoremap <silent> <Leader>ut :Unite -start-insert file_rec/async<CR><CR>
nnoremap <silent> <Leader>uv :Unite -start-insert buffer<CR>
nnoremap <silent> <leader>ul :Unite -start-insert line<CR><CR>
nnoremap <silent> <leader>uc :Unite -start-insert history/command<CR>
nnoremap <silent> <leader>uy :Unite history/yank<CR>
nnoremap <silent> <Leader>um :Unite -start-insert file_mru<CR>
nnoremap <silent> <leader>us :Unite history/search<CR>
nnoremap <silent> <leader>up :Unite grep:./*<CR>
nnoremap <silent> <leader>ug :UniteWithCursorWord grep:./*<CR>
nnoremap <silent> <leader>ub :Unite grep:$buffers<CR>
nnoremap <silent> <leader>uw :UniteWithCursorWord grep:$buffers<CR>
nnoremap <silent> <leader>uf :UniteWithCursorWord file_rec/async<CR>
nnoremap <silent> <leader>ud :UniteWithBufferDir -start-insert file<CR>
nnoremap <silent> <leader>uj :Unite -start-insert jump<CR>

" Tabularize
cnoremap <leader>ta Tabularize

" Vim Airline
let g:airline#extensions#tabline#enabled  = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme="serene"
let g:airline_section_c = ''

" Vim NerdCommenter
let g:NERDCreateDefaultMappings=0
map <leader>cc <plug>NERDCommenterToggle

" Vim Bufferline
"let g:bufferline_fname_mod = ':t'
"let g:bufferline_echo = 0
