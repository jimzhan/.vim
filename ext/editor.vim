" ---------------------------------------------------------------------------
"  Editing:
"   * Emmet: previously known as Zen Coding is a web-developer’s toolkit that
"           can greatly improve HTML/CSS workflow by combining shortcuts & snippets.
"   * Surround: CRUD for parentheses, brackets, quotes, XML tags, and more.
"   * AutoPairs: Insert or delete brackets, parens, quotes in pair.
"   * Multiple Curosr: Multiple selection/editing like Sublime Text.
" ---------------------------------------------------------------------------
Plug 'moll/vim-bbye'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'

Plug 'godlygeek/tabular' "{{{
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
"}}}

Plug 'mattn/emmet-vim' "{{{
  let g:user_emmet_settings = {
  \    'indentation' : '  '
  \}
  let g:user_emmet_expandabbr_key="<C-e>"
"}}}

Plug 'ntpeters/vim-better-whitespace' "{{{
  let g:better_whitespace_enabled = 1
  let g:better_whitespace_filetypes_blacklist=['vimfiler']
"}}}

Plug 'mbbill/undotree' "{{{
  let g:undotree_WindowLayout = 4
  nnoremap <Leader>u :UndotreeToggle<cr>
"}}}
