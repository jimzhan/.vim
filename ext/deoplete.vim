Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "{{{
  let g:deoplete#enable_at_startup = 1
"}}}

Plug 'carlitux/deoplete-ternjs'
" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
