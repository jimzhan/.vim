Plug 'mileszs/ack.vim' "{{{
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

  nmap <silent> <leader>ag :Ack
"}}}
