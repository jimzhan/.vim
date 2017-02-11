function! NeomakeESlintChecker()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let b:neomake_javascript_eslint_exe = l:eslint
  let g:neomake_javascript_enabled_makers = ['eslint']
endfunction


Plug 'neomake/neomake' "{{{
  autocmd FileType javascript :call NeomakeESlintChecker()
  " open list automatically but preserve cursor position
  let g:neomake_open_list = 2
  let g:neomake_list_height = 1

  autocmd! BufWinEnter,BufWritePost * Neomake
"}}}
