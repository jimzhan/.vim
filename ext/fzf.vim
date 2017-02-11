Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let g:fzf_nvim_statusline = 0 " disable statusline overwriting
nnoremap <silent><leader>f :Files<CR>
nnoremap <silent><C-p>     :Files<CR>
nnoremap <silent><leader>a :Buffers<CR>
nnoremap <silent><leader>A :Windows<CR>
nnoremap <silent><leader>; :BLines<CR>
nnoremap <silent><leader>o :BTags<CR>
nnoremap <silent><leader>O :Tags<CR>
nnoremap <silent><leader>? :History<CR>
nnoremap <silent><leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent><leader>. :AgIn

nnoremap <silent>K :call SearchWordWithAg()<CR>
vnoremap <silent>K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent><leader>gl :Commits<CR>
nnoremap <silent><leader>ga :BCommits<CR>
nnoremap <silent><leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
