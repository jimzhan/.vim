let g:plugins = {}
" ---------------------------------------------------------------------------
"   Platforms
" ---------------------------------------------------------------------------
" Identify platform
silent function! IsMac()
  return has('macunix')
endfunction

silent function! IsLinux()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction

silent function! IsWindows()
  return  (has('win32') || has('win64'))
endfunction


" ---------------------------------------------------------------------------
"  Helpers
" ---------------------------------------------------------------------------
" Initialize Package Manager
function! InitializePlugins()
  if !filereadable(expand('$HOME/.vim/autoload/plug.vim'))
    echo "[*] Installing Vim-Plug..."
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:plugins.initialized = 0
  endif
endfunction

" Strip whitespace
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction


" Make the ErrorSign of Syntastic in red along with default background color.
function! ResetSyntasticColors()
  exec 'hi SyntasticErrorSign guifg=#FF0000 ctermfg=196' .
    \' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
    \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
endfunction
