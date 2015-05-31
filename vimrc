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
let g:dotvim.plugins = {}
let g:dotvim.plugins.initialized = 1
source $HOME/.vim/functions.vim

" ---------------------------------------------------------------------------
"  General
" ---------------------------------------------------------------------------
set visualbell t_vb=                            " Disable alert sound
syntax on                                       " Syntax highlighting
filetype plugin indent on                       " Automatically detect file types.
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
set modelines=0

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
winsize 170 100                 " workspace size
if has('gui_running')
  set shell=/bin/bash           " Use basic bash ONLY.
  set guioptions-=T             " Remove the toolbar
  set guioptions-=L             " Remove the scollbar
  set guifont=Monaco\ for\ Powerline:h14
  set transparency=15
endif

highlight clear SignColumn              " SignColumn should match background
highlight clear LineNr                  " Current line number row will have same background color in relative mode
highlight clear CursorLineNr            " Remove highlight color from current line number
highlight ExtraWhitespace ctermbg=166   " Highlight extra whitespace in specific color

if has('cmdline_info')
  set ruler                   " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set showcmd                 " Show partial commands in status line and Selected characters/lines in visual mode
endif

set laststatus=2                " For vim-airline
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set winminheight=0              " Windows can be 0 line high
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" ---------------------------------------------------------------------------
"  Search
" ---------------------------------------------------------------------------
nnoremap / /\v
vnoremap / /\v
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set gdefault                    " :%s/foo/bar/  =>   :%s/foo/bar/g


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
if !filereadable(expand('$HOME/.vim/autoload/plug.vim'))
  echo "[*] Installing Vim-Plug..."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:dotvim.plugins.initialized = 0
endif

call plug#begin(expand('~/.vim/.plugins'))
" ---------------------------------------------------------------------------
Plug 'moll/vim-bbye'
Plug 'yonchu/accelerated-smooth-scroll'
Plug 'Shougo/vimshell.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' } "{
  let g:vimshell_enable_smart_case   = 1
  let g:vimshell_prompt              = '➤ '
  let g:vimshell_user_prompt         = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_temporary_directory = "/tmp/vimshell"
  "let g:vimshell_right_prompt        = 'system("date")'
"}

" ---------------------------------------------------------------------------
"  Plugins: File Manager
" ---------------------------------------------------------------------------
Plug 'Shougo/unite.vim' | Plug 'Shougo/neomru.vim' "{
  let g:unite_prompt              = '➤ '
  let g:unite_winheight           = 15
  let g:unite_split_rule          = 'botright'
  let g:unite_enable_ignore_case  = 1
  let g:unite_enable_smart_case   = 1
  let g:unite_enable_start_insert = 1

  let g:unite_data_directory = g:dotvim.tempdir . 'unite'
  let g:unite_source_file_mru_limit = 200
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_rec_max_cache_files=5000

  nnoremap <Leader>/  :Unite grep:.<cr>
  nnoremap <Leader>f  :Unite file_rec/async<CR>
  nnoremap <Leader>y  :Unite history/yank<CR>
  "nnoremap <Leader>s  :Unite -quick-match buffer<CR>
  "nnoremap <Leader>n  :Unite -buffer-name=New -profile-name=files file/new<CR>

  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    imap <silent><buffer> <C-k> <C-p>
    imap <silent><buffer> <C-j> <C-n>
    imap <silent><buffer> <C-d> <CR>
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source(
          \ 'file_rec,file_rec/async',
          \ 'ignore_pattern',
          \ '(\.meta$|\.tmp|node_modules|jspm_packages)')
  endfunction

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
    let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden --ignore ' .
                                        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
  endif
"}
" ---------------------------------------------------------------------------
Plug 'Shougo/vimfiler.vim' | Plug 'Shougo/unite.vim' "{
  let g:vimfiler_enable_auto_cd = 1
  let g:vimfiler_enable_clipboard = 0
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_ignore_pattern = '\%(.DS_Store\|.pyc\|.git\w*\|.sw\w*\|.hg\|.svn\)$'
  let g:vimfiler_data_directory =  g:dotvim.tempdir . "vimfiler"
  let g:vimfiler_force_overwrite_statusline = 0

  let g:vimfiler_tree_leaf_icon = ''
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_default_columns = ''
  let g:vimfiler_explorer_columns = ''
  let g:vimfiler_tree_indentation = 3
  let g:vimfiler_file_icon = '·'
  let g:vimfiler_marked_file_icon = '✩'
  let g:vimfiler_readonly_file_icon = '○'

  autocmd FileType vimfiler setlocal nonumber
  autocmd FileType vimfiler setlocal norelativenumber
  autocmd FileType vimfiler nunmap <buffer> <C-l>
  autocmd FileType vimfiler nunmap <buffer> <S-m>
  autocmd FileType vimfiler nmap <buffer> r   <Plug>(vimfiler_redraw_screen)
  autocmd FileType vimfiler nmap <buffer> u   <Plug>(vimfiler_switch_to_parent_directory)
  autocmd FileType vimfiler nmap <buffer> <Leader>n           <Plug>(vimfiler_new_file)
  autocmd FileType vimfiler nmap <buffer> <silent><Leader>r   <Plug>(vimfiler_rename_file)
  autocmd FileType vimfiler nmap <buffer> <silent><Leader>m   <Plug>(vimfiler_move_file)
  autocmd FileType vimfiler nmap <buffer> <S-m-k> <Plug>(vimfiler_make_directory)

  nmap <silent><buffer><expr> <Cr> vimfiler#smart_cursor_map(
    \ "\<Plug>(vimfiler_expand_tree)",
    \ "\<Plug>(vimfiler_edit_file)")

  nnoremap <C-o> :VimFilerExplorer -parent -toggle -status -split -simple -winwidth=30 -no-quit<CR>
"}


" ---------------------------------------------------------------------------
"  Plugins: Color Themes
" ---------------------------------------------------------------------------
Plug 'chriskempson/base16-vim' "{
  let base16colorspace=256
"}
Plug 'altercation/vim-colors-solarized'


" ---------------------------------------------------------------------------
"  Plugins: GIT Manager
" ---------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' "{
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
  autocmd BufReadPost Fugitive://* set bufhidden=delete
  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
"}


" ---------------------------------------------------------------------------
"  Plugins: Comment Helper
" ---------------------------------------------------------------------------
Plug 'scrooloose/nerdcommenter'


" ---------------------------------------------------------------------------
"  Plugins: Status Line Enhancement
" ---------------------------------------------------------------------------
Plug 'bling/vim-airline' "{{
  let g:airline_powerline_fonts=1
  let g:airline_theme='base16'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
"}}


" ---------------------------------------------------------------------------
"  Plugins: Source Code Tags
" ---------------------------------------------------------------------------
if executable('ctags') "{{
  Plug 'majutsushi/tagbar'
  let g:tagbar_width=30
  "autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.go call tagbar#autoopen()
  nnoremap <silent> <Leader>tt :TagbarToggle<CR>
  " If using go please install the gotags program using the following
  " go install github.com/jstemmer/gotags
  " And make sure gotags is in your path
  if executable('gotags')
    let g:tagbar_type_go = {
\     'ctagstype' : 'go',
\     'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
\                   't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
\                   'r:constructor', 'f:functions' ],
\     'sro' : '.',
\     'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
\     'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
\     'ctagsbin'  : 'gotags',
\     'ctagsargs' : '-sort -silent'
\   }
  endif
endif
"}}


" ---------------------------------------------------------------------------
"  Plugins: Languages
" ---------------------------------------------------------------------------
Plug 'fatih/vim-go' "{
  let g:go_fmt_autosave = 1
  let g:go_fmt_command = "goimports"
  let g:go_disable_autoinstall = 0
  nnoremap <silent> <leader>bb :GoInstall<CR>
"}
" ---------------------------------------------------------------------------
Plug 'tpope/vim-markdown' "{
  au BufRead,BufNewFile *.md set filetype=markdown
"}
Plug 'tpope/vim-haml'
" ---------------------------------------------------------------------------
Plug 'othree/html5.vim'
Plug 'lepture/vim-jinja'
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
" ---------------------------------------------------------------------------
Plug 'mxw/vim-jsx' | Plug 'pangloss/vim-javascript' "{
  let g:jsx_ext_required = 1
  let g:jsx_pragma_required = 0
"}
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'underscore,react'
" ---------------------------------------------------------------------------
Plug 'groenewege/vim-less'
Plug 'leafgarland/typescript-vim'
Plug 'clausreinke/typescript-tools.vim'


" ---------------------------------------------------------------------------
"  Plugins: Static Syntax Checking
" ---------------------------------------------------------------------------
Plug 'scrooloose/syntastic' "{
  hi SyntasticErrorSign ctermfg=196 guifg=#FF0000
  let g:syntastic_enable_signs = 1
  let g:syntastic_error_symbol = "✘"
  let g:syntastic_warning_symbol = "➤ "
  let g:syntastic_style_error_symbol = '✠'
  let g:syntastic_style_warning_symbol = '☢'
  let g:syntastic_check_on_open = 1

  if has('balloon_eval')
    let g:syntastic_enable_balloons = 1
  endif
  let g:syntastic_javascript_checkers = ['eslint']

  let g:syntastic_typescript_tsc_args = '--target ES7'
"}


" ---------------------------------------------------------------------------
"  Editing:
"   * Emmet: previously known as Zen Coding is a web-developer’s toolkit that
"           can greatly improve HTML/CSS workflow by combining shortcuts & snippets.
"   * Surround: CRUD for parentheses, brackets, quotes, XML tags, and more.
"   * AutoPairs: Insert or delete brackets, parens, quotes in pair.
"   * Multiple Curosr: Multiple selection/editing like Sublime Text.
" ---------------------------------------------------------------------------
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular' "{
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
"}
Plug 'mattn/emmet-vim' "{
  let g:user_emmet_settings = {
  \    'indentation' : '  '
  \}
  let g:user_emmet_expandabbr_key="<C-e>"
"}
Plug 'terryma/vim-multiple-cursors' "{
function! Multiple_cursors_before()
  exe 'NeoCompleteLock'
  echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
  exe 'NeoCompleteUnlock'
  echo 'Enabled autocomplete'
endfunction
"}
Plug 'ntpeters/vim-better-whitespace' "{
  let g:better_whitespace_enabled = 1
  let g:better_whitespace_filetypes_blacklist=['vimfiler']
  "highlight ExtraWhitespace ctermbg=166
"}
Plug 'sjl/gundo.vim' "{
  let g:gundo_right = 1
  nnoremap <Leader>u :GundoToggle<CR>
"}


" ---------------------------------------------------------------------------
"  AutoComplete: AutoComplete & Code Snippets/Templates
" ---------------------------------------------------------------------------
Plug 'Shougo/neocomplete' "{
  set completeopt-=preview
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup       = 1
  let g:neocomplete#enable_smart_case       = 1
  let g:neocomplete#enable_ignore_case      = 1
  let g:neocomplete#enable_fuzzy_completion = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  inoremap <expr><TAB>    pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><CR>     pumvisible() ? neocomplete#close_popup() : "\<CR>"
  if !exists('g:neocomplete#omni_patterns')
    let g:neocomplete#omni_patterns = {}
  endif
  let g:neocomplete#omni_patterns.go = '\h\w*\.\?'
"}
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' } "{
  autocmd FileType javascript nested setlocal omnifunc=javascriptcomplete#CompleteJS
"}
" ---------------------------------------------------------------------------
Plug 'aperezdc/vim-template' " {
  let g:templates_directory = expand('~/.vim/templates')
"}
Plug 'honza/vim-snippets', {'depends': 'SirVer/ultisnips'} " {
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsExpandTrigger="<TAB>"
  let g:UltiSnipsJumpForwardTrigger="<TAB>"
  let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
  let g:UltiSnipsRemoveSelectModeMappings = 0
  let g:ultisnips_python_style = "google"     " Available Styles: doxygen | sphinx | google
"}
call plug#end()

if g:dotvim.plugins.initialized == 0
  :PlugInstall
endif


" ---------------------------------------------------------------------------
"  Local Settings
" ---------------------------------------------------------------------------
colorscheme base16-solarized
if filereadable(expand('$HOME/.vimrc.local'))
  source $HOME/.vimrc.local
endif
call g:dotvim.ResetSyntasticColors()
