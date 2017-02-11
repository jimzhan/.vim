Plug 'Shougo/vimfiler.vim' | Plug 'Shougo/unite.vim' "{{{
"  hi cursorline guibg=\#333333     " highlight bg color of current
  let g:vimfiler_enable_auto_cd = 1
  let g:vimfiler_enable_clipboard = 0
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimfiler_data_directory =  g:dotvim.tempdir . "vimfiler"

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
  autocmd FileType vimfiler setlocal cursorline
  autocmd FileType vimfiler nunmap <buffer> <C-l>
  autocmd FileType vimfiler nunmap <buffer> <S-m>
  autocmd FileType vimfiler nmap <buffer> r   <Plug>(vimfiler_redraw_screen)
  autocmd FileType vimfiler nmap <buffer> u   <Plug>(vimfiler_switch_to_parent_directory)
  autocmd FileType vimfiler nmap <buffer> <Leader>n           <Plug>(vimfiler_new_file)
  autocmd FileType vimfiler nmap <buffer> <silent><Leader>r   <Plug>(vimfiler_rename_file)
  autocmd FileType vimfiler nmap <buffer> <silent><Leader>m   <Plug>(vimfiler_move_file)
  autocmd FileType vimfiler nmap <buffer> <S-m-k> <Plug>(vimfiler_make_directory)

  nmap <silent><buffer><expr> <Cr> vimfiler#smart_cursor_map(
    "\ "\<Plug>(vimfiler_expand_tree)",
    "\ "\<Plug>(vimfiler_edit_file)")

  nnoremap <C-o> :VimFilerExplorer -parent -toggle -status -split -simple -winwidth=39 -no-quit<CR>
"}}}
