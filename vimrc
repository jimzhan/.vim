set nocompatible
" ---------------------------------------------------------------------------
"  environments
" ---------------------------------------------------------------------------
let g:dotvim = {}
let g:dotvim.root = $HOME . "/.vim"
let g:dotvim.tempdir = g:dotvim.root . "/tmp/"

let g:dotvim.plugins = {}
let g:dotvim.plugins.initialized = 1
let g:dotvim.plugins.root = g:dotvim.root . '/plugins'

" ---------------------------------------------------------------------------
"  foundations
" ---------------------------------------------------------------------------
runtime! etc/base.vim
runtime! etc/keymap.vim
runtime! etc/funtion.vim
runtime! etc/platform.vim
" ---------------------------------------------------------------------------
"  Package Manager
" ---------------------------------------------------------------------------
if !filereadable(expand('$HOME/.vim/autoload/plug.vim'))
  echo "[*] Installing Vim-Plug..."
  silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:dotvim.plugins.initialized = 0
endif
call plug#begin(expand('$HOME/.vim/plugins'))

" ---------------------------------------------------------------------------
" Plugins: Settings
" ---------------------------------------------------------------------------
runtime! ext/theme.vim

runtime! ext/editor.vim
runtime! ext/syntastic.vim

runtime! ext/ack.vim
runtime! ext/ctrlp.vim
runtime! ext/nerdtree.vim
runtime! ext/tmux.vim

" ---------------------------------------------------------------------------
call plug#end()
if g:dotvim.plugins.initialized == 0
  :PlugInstall
endif
" ---------------------------------------------------------------------------

" ---------------------------------------------------------------------------
" called only after plugins initialized.
" ---------------------------------------------------------------------------
colorscheme base16-solarized-dark
call ResetSyntasticColors()

