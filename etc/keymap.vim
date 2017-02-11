" ---------------------------------------------------------------------------
"  Key Mappings
" ---------------------------------------------------------------------------
let mapleader = ','     " The default Leader is '\'.
imap jj <ESC>           " Shortcut to ESC
nmap <leader>w :w!<CR>  " Fast saving

" Code folding options
" ----------------
"" toggle folding using `space`.
"   do not fold lines under 5.
"set foldlevel=9
set foldminlines=6
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>
nmap <leader>0 :set foldlevel=0<CR>
nmap <leader>1 :set foldlevel=1<CR>
nmap <leader>2 :set foldlevel=2<CR>
nmap <leader>3 :set foldlevel=3<CR>
nmap <leader>4 :set foldlevel=4<CR>
nmap <leader>5 :set foldlevel=5<CR>
nmap <leader>6 :set foldlevel=6<CR>

nmap <leader>7 :set foldlevel=7<CR>
nmap <leader>8 :set foldlevel=8<CR>
nmap <leader>9 :set foldlevel=9<CR>

" Buffer Switching
" ----------------
:nmap <C-l>     :bnext<CR>
:nmap <C-h>     :bprevious<CR>
:nmap <C-k>     :Bdelete<CR>    " via vim-bbye

" System Clipboard
" ----------------
vmap <Leader>y "+y
map  <Leader>x "+x
map  <Leader>p "+p

if has('nvim')
  nmap <leader>sh :terminal<CR>
endif

nnoremap <D-down> :resize +5<cr>
nnoremap <D-up> :resize -5<cr>

nnoremap <Leader>- :vertical resize -5<cr>
nnoremap <Leader>+ :vertical resize +5<cr>
