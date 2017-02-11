if has('persistent_undo')
  set undofile
  set undodir=~/.vim/.undo
endif

" ---------------------------------------------------------------------------
"  General
" ---------------------------------------------------------------------------" Behaviors {{{
filetype plugin indent on  " Automatically detect file types. (must turn on after Vundle)
set wildmode=list:longest " use emacs-style tab completion when selecting files, etc
set hidden             " Change buffer - without saving
set autowriteall       " Writes on make/shell commands
" set foldmethod=syntax
set foldlevel=20
set formatoptions=crql
set iskeyword+=$,@,-     " Add extra characters that are valid parts of variables
set tags=./tags;/,tags;/
set splitright
if version >= 704
  set completeopt=menu,noinsert,noselect
endif
" }}}

" Text Format {{{
set tabstop=2
set shiftwidth=2 " Tabs under smart indent
set expandtab
" }}}

set noerrorbells
set novisualbell

set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes


" ---------------------------------------------------------------------------
"  User Interface
" ---------------------------------------------------------------------------
syntax enable
set background=dark
set nu             " Line numbers on
set nowrap         " Line wrapping off
set cmdheight=1    " Make the command area two lines high
set noshowmode     " don't need to show mode since we have airline
set numberwidth=4
set encoding=utf-8
set guioptions=acg
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
"set cursorline
if !has('nvim')
  set ttyfast
endi
set lazyredraw
if exists('+colorcolumn')
  set colorcolumn=100 " Color the 80th column differently
endif

if !has('nvim')
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
end

highlight clear SignColumn              " SignColumn should match background
"highlight clear CursorLineNr            " Remove highlight color from current line number
highlight ColorColumn ctermbg=7         " Custom Colored Column
highlight ExtraWhitespace ctermbg=7   " Highlight extra whitespace in specific color


" ---------------------------------------------------------------------------
"  Searching
" ---------------------------------------------------------------------------
set ignorecase
set smartcase  " Non-case sensitive search
set hlsearch
if executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
  set grepformat=%f:%l:%c:%m
endif
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif
set noshowmatch " Disable jumping to matching bracket when typing
set wildignore+=.final_builds/*,*/node_modules/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class,*.scssc,*/Godeps/*
