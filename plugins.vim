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
