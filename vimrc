" ------------------------------------------------------------
" *  @author     Jim Zhan <jim.zhan@me.com>
" *
" Copyright © 2015 Jim Zhan.
" ------------------------------------------------------------
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" ---------------------------------------------------------------------------
"  Settings
" ---------------------------------------------------------------------------
let g:dotvim = {}
let g:dotvim.root = $HOME . "/.vim/"
let g:dotvim.tempdir = $HOME . "/.vim/tmp/"
let g:dotvim.bundle = {}
let g:dotvim.bundle.Initialized = 1
source $HOME/.vim/base.vim

" ---------------------------------------------------------------------------
"  General
" ---------------------------------------------------------------------------
syntax on                                       " Syntax highlighting
filetype plugin indent on                       " Automatically detect file types.
"set clipboard=unnamed
set autowrite                                   " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set history=1000                                " Store a ton of history (default is 20)
"set spell                                       " Spell checking on
set hidden                                      " Allow buffer switching without saving
set iskeyword-=.                                " '.' is an end of word designator
set iskeyword-=#                                " '#' is an end of word designator
set iskeyword-=-                                " '-' is an end of word designator

" Setting up the directories
set backup                      " Backups are nice ...
if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

call dotvim.RestoreCursor()


" To disable views add the following to your .vimrc file:
" ---------------------------------------------------------------------------
"  let g:dotvim.no_views = 1
" ---------------------------------------------------------------------------
if !exists('g:dotvim.no_views')
  " Add exclusions to mkview and loadview
  " eg: *.*, svn-commit.tmp
  let g:skipview_files = [
\   '\[example pattern\]'
\ ]
endif


" ---------------------------------------------------------------------------
"  User Interface
" ---------------------------------------------------------------------------
set background=dark             " Assume a dark background
set t_Co=256                    " Enable 256 colors (stop CSApprox warning and make xterm vim shine)
set term=$TERM                  " Make arrow and other keys work
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line
set colorcolumn=80              " Enable Vertical Color Column at 80.

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
  set ruler                   " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set showcmd                 " Show partial commands in status line and
                              " Selected characters/lines in visual mode
endif

set laststatus=2                " For vim-airline
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" ---------------------------------------------------------------------------
"  Formatting
" ---------------------------------------------------------------------------
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" ---------------------------------------------------------------------------
autocmd BufRead,BufNewFile *.es set filetype=javascript
autocmd BufRead,BufNewFile *.es6 set filetype=javascript
autocmd BufRead,BufNewFile *.es7 set filetype=javascript
autocmd BufRead,BufNewFile *.coffee set filetype=coffee
autocmd BufRead,BufNewFile *.html.twig set filetype=html.twig


" ---------------------------------------------------------------------------
"  Key Mappings
" ---------------------------------------------------------------------------
let mapleader = ','     " The default Leader is '\'.
imap jj <ESC>           " Shortcut to ESC
" Code folding options
" ----------------
"" toggle folding using `space`.
"   do not fold lines under 5.
"set foldlevel=9
set foldminlines=6
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>
nmap <leader>0 :set foldlevel=0<CR>
nmap <leader>1 :set foldlevel=1<CR>
nmap <leader>2 :set foldlevel=2<CR>
nmap <leader>3 :set foldlevel=3<CR>
nmap <leader>4 :set foldlevel=4<CR>
nmap <leader>5 :set foldlevel=5<CR>
nmap <leader>6 :set foldlevel=6<CR>
nmap <leader>7 :set foldlevel=7<CR>
nmap <leader>8 :set foldlevel=8<CR>
nmap <leader>9 :set foldlevel=9<CR>
" Buffer Switching
" ----------------
:nmap <C-l>     :bnext<CR>
:nmap <C-h>     :bprevious<CR>
:nmap <C-k>     :Bdelete<CR>
" System Clipboard
" ----------------
vmap <Leader>y "+y
map  <Leader>x "+x
map  <Leader>p "+p


" ---------------------------------------------------------------------------
" Plugins Manager: Setup Custom Plugins Support.
" ---------------------------------------------------------------------------
call dotvim.InitializePlugins(expand('~/.vimrc.plugins'))
colorscheme base16-solarized

" ---------------------------------------------------------------------------
" Finalize: Post settings & restting colors.
" ---------------------------------------------------------------------------
call dotvim.Finalize()


" ---------------------------------------------------------------------------
"  Local Settings
" ---------------------------------------------------------------------------
highlight ExtraWhitespace ctermbg=166
