Plug 'yonchu/accelerated-smooth-scroll'
" ---------------------------------------------------------------------------
"  Plugins: Color Themes
" ---------------------------------------------------------------------------
Plug 'chriskempson/base16-vim' "{{{
  let base16colorspace=256
"}}}


Plug 'vim-airline/vim-airline-themes' | Plug 'vim-airline/vim-airline' "{{{
  let g:airline_powerline_fonts=1
  let g:airline_theme='murmur'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
"}}}
