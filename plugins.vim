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
" Plugins Settings: Custom Plugins Settings.
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
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'jistr/vim-nerdtree-tabs' | Plug 'scrooloose/nerdtree' "{
  map <leader>b :Bookmark<CR>
  map <C-o> :NERDTreeTabsToggle<CR>
  nnoremap <leader>n :NERDTree .<CR>
  let NERDTreeChDirMode = 2
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore = ['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
  let NERDTreeMinimalUI = 0
  let NERDTreeQuitOnOpen = 1
  let NERDTreeMouseMode = 2
  let NERDTreeShowHidden = 1
  let NERDTreeKeepTreeInNewTab = 1

  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'

  let g:nerdtree_tabs_open_on_gui_startup=0
  let g:nerdtree_tabs_open_on_console_startup = 0
"}
" ---------------------------------------------------------------------------
"  Plugins
Plug 'tacahiroy/ctrlp-funky' | Plug 'kien/ctrlp.vim' "{
  let g:ctrlp_working_path_mode = 'ra'
  nmap <leader>f :CtrlP<cr>
  " Easy bindings for its various modes
  nmap <leader>bb :CtrlPBuffer<cr>
  nmap <leader>bm :CtrlPMixed<cr>
  nmap <leader>bs :CtrlPMRU<cr>
  let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.(git|hg|svn)$',
      \ 'file': '\.(exe|so|dll|class|pyc|png|jpg|jpeg)$' }

  if executable('ag')
      let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
  elseif executable('ack-grep')
      let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
  elseif executable('ack')
      let s:ctrlp_fallback = 'ack %s --nocolor -f'
  " On Windows use "dir" as fallback command.
  elseif IsWindows()
      let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
  else
      let s:ctrlp_fallback = 'find %s -type f'
  endif
  if exists("g:ctrlp_user_command")
      unlet g:ctrlp_user_command
  endif
  let g:ctrlp_user_command = {
      \ 'types': {
          \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
          \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ },
      \ 'fallback': s:ctrlp_fallback
  \ }

  if isdirectory(expand("~/.vim/plugins/ctrlp-funky/"))
      " CtrlP extensions
      let g:ctrlp_extensions = ['funky']

      "funky
      nnoremap <Leader>fu :CtrlPFunky<Cr>
  endif
"}
" ---------------------------------------------------------------------------


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
Plug 'vim-airline/vim-airline-themes' | Plug 'vim-airline/vim-airline' "{
  let g:airline_powerline_fonts=1
  let g:airline_theme='base16'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
"}


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
Plug 'vim-scripts/hybris-ImpEx'
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
  let g:syntastic_objc_compiler = "gcc"

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
Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips' " {
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsExpandTrigger="<TAB>"
  let g:UltiSnipsJumpForwardTrigger="<TAB>"
  let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
  let g:UltiSnipsRemoveSelectModeMappings = 0
  let g:ultisnips_python_style = "google"     " Available Styles: doxygen | sphinx | google
"}
"Plug 'rizzatti/dash.vim'
