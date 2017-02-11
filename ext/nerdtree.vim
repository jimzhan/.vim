Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'

map <leader>b :Bookmark<CR>
map <C-o> :NERDTreeTabsToggle<CR>
nnoremap <leader>n :NERDTree .<CR>

let NERDTreeChDirMode = 2
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.py[cd]$',
\   '\~$', '\.scssc$', '\.swo$', '\.swp$', '.sass-cache',
\   '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '.DS_Store',
\   'node_modules']
let NERDTreeMinimalUI = 0
let NERDTreeQuitOnOpen = 1
let NERDTreeMouseMode = 2
let NERDTreeShowHidden = 1
let NERDTreeKeepTreeInNewTab = 1

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_console_startup = 0

" direct shortcuts for CRUD without marking.
autocmd FileType NERDTree nmap <buffer> <silent>dd   m-d
autocmd FileType NERDTree nmap <buffer> <silent><Leader>d   m-d
autocmd FileType NERDTree nmap <buffer> <silent><Leader>n   m-a
autocmd FileType NERDTree nmap <buffer> <silent><Leader>c   m-c
autocmd FileType NERDTree nmap <buffer> <silent><Leader>m   m-m
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
