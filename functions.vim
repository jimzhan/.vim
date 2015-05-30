""  ------------------------------------------------------------
" *  @author     Jim Zhan <jim.zhan@me.com>
" *
" Copyright © 2015 Jim Zhan.
" ------------------------------------------------------------
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" ---------------------------------------------------------------------------
"  Functions
" ---------------------------------------------------------------------------
function! dotvim.Initialize()
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = g:dotvim.tempdir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor

  " ------------------------------------------------------------
  " Windows Compatible
  " ---------------------------------------------------------------------------
  " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
  " across (heterogeneous) systems easier.
  if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    " Be nice and check for multi_byte even if the config requires
    " multi_byte support most of the time
    if has("multi_byte")
      " Windows cmd.exe still uses cp850. If Windows ever moved to
      " Powershell as the primary terminal, this would be utf-8
      set termencoding=cp850
      " Let Vim use utf-8 internally, because many scripts require this
      set encoding=utf-8
      setglobal fileencoding=utf-8
      " Windows has traditionally used cp1252, so it's probably wise to
      " fallback into cp1252 instead of eg. iso-8859-15.
      " Newer Windows files might contain utf-8 or utf-16 LE so we might
      " want to try them first.
      set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15,chinese,euc-jp,gb18030,gbk,big5,latin1
    endif
  endif
endfunction


function! dotvim.RestoreCursor()
  function! ResCur()
    if line("'\"") <= line("$")
      normal! g`"
      return 1
    endif
  endfunction

  augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
  augroup END
endfunction


" Strip whitespace
function! dotvim.StripTrailingWhitespace()
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

" Shell command
function! s:RunShellCommand(cmdline)
    botright new

    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell

    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction

" e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)


" ---------------------------------------------------------------------------
"  Python: indent Python in the Google's way.
" ---------------------------------------------------------------------------
setlocal indentexpr=GetGooglePythonIndent(v:lnum)
let s:maxoff = 50 " maximum number of lines to look backwards.
function dotvim.GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return dotvim.GetPythonIndent(a:lnum)
endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

" ---------------------------------------------------------------------------
"  Logger: debug logger..
" ---------------------------------------------------------------------------
function! dotvim.log(msg, ...)
    let is_unite = get(a:000, 0, 0)
    let msg = type(a:msg) == type([]) ? a:msg : split(a:msg, '\n')
    call extend(s:log, msg)

    if !(&filetype == 'unite' || is_unite)
        call neobundle#util#redraw_echo(msg)
    endif

    call s:append_log_file(msg)
endfunction


" ---------------------------------------------------------------------------
"  Plugin Manager: Initialize Vundle to manage plugins.
" ---------------------------------------------------------------------------
function! dotvim.InitPlugins()
  if !filereadable(expand('$HOME/.vim/autoload/plug.vim'))
    echo "[*] Installing Vim-Plug..."
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:dotvim.plugins.initialized = 0
  endif

  source ~/.vim/plugins.vim

  if g:dotvim.plugins.initialized == 0
    :PlugInstall
  endif
endfunction

function! dotvim.InitializePlugins(config)
    " Ensure NeoBundle's Existence.
    if !filereadable(expand('$HOME/.vim/bundle/neobundle.vim/README.md'))
        echo "[*] Installing NeoBundle..."
        echo ""
        silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
        let g:dotvim.plugins.initialized = 0
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()

    source ~/.vim/plugins.vim
    if filereadable(a:config)
        source a:config
    endif

    filetype indent plugin on
    NeoBundleCheck
    if g:dotvim.plugins.initialized == 0
        :NeoBundleInstall
    endif
endfunction

" ---------------------------------------------------------------------------
" Make the ErrorSign of Syntastic in red along with default background color.
function! dotvim.ResetSyntasticColors()
  exec 'hi SyntasticErrorSign guifg=#FF0000 ctermfg=196' .
        \' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
        \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
endfunction
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
"  Finalizer: To finalize settings after all.
" ---------------------------------------------------------------------------
function! dotvim.Finalize()
  call g:dotvim.ResetSyntasticColors()
endfunction


" ---------------------------------------------------------------------------
"  Setup:
" ---------------------------------------------------------------------------
call dotvim.Initialize()
