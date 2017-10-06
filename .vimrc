if 0
██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
██                                                                                                                                                          ██
██   ███    ███  █████  ██   ██ ███████     ██    ██ ██ ███    ███      ██████  ██████  ███████  █████  ████████      █████   ██████   █████  ██ ███    ██  ██
██   ████  ████ ██   ██ ██  ██  ██          ██    ██ ██ ████  ████     ██       ██   ██ ██      ██   ██    ██        ██   ██ ██       ██   ██ ██ ████   ██  ██
██   ██ ████ ██ ███████ █████   █████       ██    ██ ██ ██ ████ ██     ██   ███ ██████  █████   ███████    ██        ███████ ██   ███ ███████ ██ ██ ██  ██  ██
██   ██  ██  ██ ██   ██ ██  ██  ██           ██  ██  ██ ██  ██  ██     ██    ██ ██   ██ ██      ██   ██    ██        ██   ██ ██    ██ ██   ██ ██ ██  ██ ██  ██
██   ██      ██ ██   ██ ██   ██ ███████       ████   ██ ██      ██      ██████  ██   ██ ███████ ██   ██    ██        ██   ██  ██████  ██   ██ ██ ██   ████  ██
██                                                                                                                                                          ██
██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
endif

""" General options
filetype on " Enable filetype plugin
filetype plugin on
filetype indent on
set nocompatible " We use Vim, not Vi
set ttyfast " Faster redraw
set lazyredraw " Don't redraw statusline when switching between vim modes
set shortmess+=I " No intro when starting Vim
set expandtab " Insert spaces instead of tabs
set smarttab " Insert spaces according to shiftwidth
set softtabstop=4 " ... and insert four spaces
set shiftwidth=4 " Indent with four spaces
set incsearch " Search as typing
set hlsearch " Highlight search results
set cursorline " Highlight the cursor line
set virtualedit=onemore " Allow the cursor to move just past the end of the line
set history=10000 " Maximum 10000 undo
set wildmenu " Better command-line completion
set wildignorecase " Ignore case when command-line completion
" set scrolloff=999 " Always keep max lines after or before when scrolling
" set sidescrolloff=999 " Always keep max lines after or before whens side scrolling
set guicursor=a:ver25-Cursor/lCursor-blinkon0 " disable cursor flashing
set clipboard=unnamed,unnamedplus,exclude:.*
set selection=exclusive " Don't select char under cursor
set mouseshape+=a:beam " set cursor shape as modern editors should be
set mouse=a
set autoindent " auto indent
set smartindent " smart indent
set noshowmode " Don't display the current mode
set gdefault " The substitute flag g is on
set hidden " Hide the buffer instead of closing when switching
set backspace=indent,eol,start " The normal behaviour of backspace
set showtabline=2 " Always show tabs
set laststatus=2 " Always show status bar
set whichwrap=<,>,[,] " Alow arrow keys move to previous/next line
set updatetime=8000 " How long will vim backup a file
set autoread " Auto reload content if it changed outside of vim
set tabpagemax=5000 " Max tab pages
set ignorecase " case insensitive but case sensitive in command mode
let &showbreak="\u21aa " " Show a left arrow when wrapping text
set mousemodel=extend " Disable right click popup in Gvim
set encoding=utf-8
set fileencodings=utf-8,gbk,big5,utf-16le,utf-16be,default,latin1
set fileformats=unix,dos " Set for terminal vim
set viminfo+=n$HOME/dotfile/.viminfo " .viminfo location
set synmaxcol=3000 " Don't try to highlight lines with over 3000 characters
autocmd VimEnter * set noerrorbells " Disable error sound
set vb t_vb= " disable visual bell
set t_vb= " disable visual bell
autocmd VimEnter * set vb t_vb= " Disable visual bell
set smartcase& " No smart
set nowrap " Don't wrap text
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
set iskeyword=a-z,A-Z,48-57,_
set guioptions-=T " Don't show toolbar in Gvim
set guioptions+=b " Show bottom (horizontal) scrollbar in Gvim
set guitabtooltip=%{expand('%:p')} " Use full path in GUI tab tooltip
let g:netrw_list_hide='' " Show all hidden files when using file explorer
let g:netrw_hide=0 " Show all hidden files when using file explorer
let g:netrw_sizestyle="H" " Human-readable file size in file explorer
let g:netrw_liststyle=1 " Like 'ls -al' in file explorer
let g:netrw_timefmt="" " Don't display time in file explorer
let g:vertical_jump=&scroll*4/3 " Jump when Ctrl up/down triggered
au VimResized * let g:vertical_jump=&scroll*4/3
au FileType vim,conf,sh,zsh setlocal ts=2 sw=2 sts=2 " 2 spaces indent
" Highlight code area in markdown
let g:markdown_fenced_languages =
\[
  \"c","cpp","java","javascript","ruby","python","vim",
  \"css","html","xml","json","cmake","yaml","sh","conf",
  \"zsh","tmux","debsources","resolv","sudoers"
\]
" Open all cmd args in new tabs
execute ":silent tab all"
" Open help in new tabs
cnoreabbrev help <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tab help' : 'help')<CR>
cnoreabbrev h <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tab help' : 'h')<CR>
cnoreabbrev edit <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tabedit' : 'edit')<CR>
cnoreabbrev e <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tabedit' : 'e')<CR>

""" Prevent lag when hitting ESC
set ttimeoutlen=10
set timeoutlen=10
au InsertEnter * set timeoutlen=400
au InsertLeave * set timeoutlen=10

""" When opening a file : - Reopen at last position - Display info
function! GetFileInfo()
  let permissions = getfperm(expand('%:p'))
  echon  &filetype . ", " . GetFileSize() . ", " . permissions
endfunction
function! GetFileSize()
  let bytes = getfsize(expand('%:p'))
  if bytes <= 0
     return ""
  elseif bytes > 1024*1000*1000
    return (bytes / 1024*1000*1000) . "GB"
  elseif bytes > 1024*1000
    return (bytes / 1024*1000) . "MB"
  elseif bytes > 1024
    return (bytes / 1024) . "KB"
  else
     return bytes . "B"
  endif
endfunction
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | call GetFileInfo()
""" Custom backup and swap files
let myVimDir = expand("$HOME/dotfile/.vim")
let myBackupDir = myVimDir . '/backup'
let mySwapDir = myVimDir . '/swap'
let myUndoDir = myVimDir . '/undo'
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir,'p')
  endif
endfunction
call EnsureDirExists(myVimDir)
call EnsureDirExists(myBackupDir)
call EnsureDirExists(mySwapDir)
call EnsureDirExists(myUndoDir)
set backup
set backupskip=/tmp/*
set backupext=.bak
let &directory = mySwapDir
let &backupdir = myBackupDir
let &undodir = myUndoDir
set writebackup

" Helper functions
function! CreateShortcut(keys, cmd, where, ...)
  let keys = "<" . a:keys . ">"
  if a:where =~ "i"
    let i = (index(a:000,"noTrailingIInInsert") > -1) ? "" : "i"
    let e = (index(a:000,"noLeadingESCInInsert") > -1) ? "" : "<ESC>"
    execute "inoremap " . keys . " " . e .  a:cmd . i
  endif
  if a:where =~ "n"
    execute "nnoremap " . keys . " " . a:cmd
  endif
  if a:where =~ "v"
    let k = (index(a:000,"restoreSelectionAfter") > -1) ? "gv" : ""
    let c = a:cmd
    if index(a:000,"cmdInVisual") > -1
      let c = ":<C-u>" . strpart(a:cmd,1)
    endif
    execute "vnoremap " . keys . " " . c . k
  endif
endfunction
function! TabIsEmpty()
    return winnr('$') == 1 && len(expand('%')) == 0 && line2byte(line('$') + 1) <= 2
endfunction
function! MyQuit()
  redir => bufferActive | silent exec 'buffers a' | redir END
  let g:bufferNum = len(split(bufferActive, "\n"))
  if TabIsEmpty() == 1
    q!
  else
    if &modified
      if (confirm("YOU HAVE UNSAVED CHANGES! Wanna quit anyway?", "&Yes\n&No", 2)==1)
        q!
      endif
    else
      q
    endif
  endif
endfunction
function! MySave()
  " Remove trailing space
  normal! mj
  execute "%s/\\s\\+$//e"
  let cantSave = "echo \"Can't save the file: \" . v:exception | return"
  let notSaved = "redraw | echo 'This buffer was NOT saved!' | return"
  try
    silent w
  catch /:E45:\|:E505:\|:E212:/
    if (confirm("This buffer is read only! Wanna save it anyway?", "&Yes\n&No", 2)==1)
      try
        silent w!
      catch /:E212:/
        if (confirm("Can't open the file, do you want to save it as root?", "&Yes\n&No", 2)==1)
          try
            w !sudo tee % > /dev/null
            edit!
          catch
            exe cantSave
          endtry
        else
          exe notSaved
        endif
      catch
        exe cantSave
      endtry
    else
      exe notSaved
    endif
  catch /:E32:/
    if (confirm("This buffer has no file to be saved in! Wanna choose it?", "&Yes\n&No", 2)==1)
      execute has("gui_running") ? 'browse confirm saveas %:p:h' : 'call feedkeys("\<ESC>:w ")'
    else
      exe notSaved
    endif
  catch
    exe cantSave
  endtry
  let time = strftime("%T")
  let file = expand('%:p')
  let permissions = getfperm(file)
  echom file . " saved at " . time | redraw
  echohl iGreen | echon "    SAVED     "
  echohl Green | echon  " " . GetFileSize() . ", " . time . ", " . permissions
  echohl None
  try
    normal! `j
  catch /:E20:/
    " mark not set error
    echon "Mark not set, Try again"
  endtry
endfunction
function! OpenLastBufferInNewTab()
  redir => ls_output
  silent exec 'ls'
  redir END
  let ListBuffers = reverse(split(ls_output, "\n"))
  for line in ListBuffers
    let title = split(line, "\"")[1]
    if title !~  "\[No Name"
      execute "tabnew +" . split(line, " ")[0] . "buf"
      break
    endif
  endfor
endfunction
function! OpenNetrw()
  if TabIsEmpty() == 1
    execute has("gui_running") ? "browse confirm e %:p:h" : "Explore %:p:h"
  else
    execute has("gui_running") ? "browse confirm tabe %:p:h" : "Texplore %:p:h"
  endif
endfunction
function! MenuNetrw()
  let c = input("What to you want to do? (M)ake a dir, Make a (F)ile, (R)ename, (D)elete : ")
  if (c == "m" || c == "M")
    normal! d
  elseif (c == "f" || c == "F")
    normal! %
  elseif (c == "r" || c == "R")
    normal! R
  elseif (c == "d" || c == "D")
    normal! D
  endif
endfunction
function! SavePos()
  let b:savepos = getpos(".")
endfunction
function! DeleteLine()
  let savepos = getpos(".")
  normal! "_dd
  call setpos(".", savepos)
endfunction

" Usefull shortcuts for entering insert mode
nnoremap <CR> i<CR>
nnoremap <Backspace> i<Backspace>
nnoremap <Space> i<Space>
nnoremap " i"
nnoremap ' i'
nnoremap [ i[
nnoremap ] i]
nnoremap { i{
nnoremap } i}
nnoremap ( i(
nnoremap ) i)
nnoremap < i<
nnoremap > i>
nnoremap . i.
nnoremap , i,
nnoremap ; i;
nnoremap + i+
nnoremap = i=

" Vim undo too much
inoremap <Space> <Space><C-g>u
inoremap <CR> <CR><C-g>u
inoremap <Tab> <Tab><C-g>u

" Disable middle mouse button
nnoremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
vnoremap <MiddleMouse> <Nop>
nnoremap <2-MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
vnoremap <2-MiddleMouse> <Nop>
nnoremap <3-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
vnoremap <3-MiddleMouse> <Nop>
nnoremap <4-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>
vnoremap <4-MiddleMouse> <Nop>

" Meta LeftMouse is block selecting
noremap  <M-LeftMouse> <4-LeftMouse>
inoremap <M-LeftMouse> <4-LeftMouse>
onoremap <M-LeftMouse> <C-C><4-LeftMouse>
noremap  <M-LeftDrag>  <LeftDrag>
inoremap <M-LeftDrag>  <LeftDrag>
onoremap <M-LeftDrag>  <C-C><LeftDrag>

" Ctrl LeftMouse is block selecting
noremap  <C-LeftMouse> <4-LeftMouse>
inoremap <C-LeftMouse> <4-LeftMouse>
onoremap <C-LeftMouse> <C-C><4-LeftMouse>
noremap  <C-LeftDrag>  <LeftDrag>
inoremap <C-LeftDrag>  <LeftDrag>
onoremap <C-LeftDrag>  <C-C><LeftDrag>

" RightMouse is block selecting
noremap  <RightMouse> <4-LeftMouse>
inoremap <RightMouse> <4-LeftMouse>
onoremap <RightMouse> <C-C><4-LeftMouse>
noremap  <RightDrag>  <LeftDrag>
inoremap <RightDrag>  <LeftDrag>
onoremap <RightDrag>  <C-C><LeftDrag>

" RightMouse double clicking moves cursor the the other side
noremap <2-RightMouse> <2-LeftMouse>o

" Ctrl A - Begin Line
call CreateShortcut("C-a", "0", "nv")
inoremap <C-a> <Home>

" Ctrl E - End Line
call CreateShortcut("C-e", "$l", "nv")
inoremap <C-e> <End>

" Ctrl C - Copy
call CreateShortcut("C-c", "mjYV:w! $HOME/dotfile/clipboard.txt<CR>:call system('chmod 777 $HOME/dotfile/clipboard.txt')<CR>:redraw!<CR>`j", "ni")
vnoremap <silent> <C-c> y:call delete(expand("$HOME/dotfile/clipboard.txt"))<CR>:new $HOME/dotfile/clipboard.txt<CR>P:w!<CR>:bdelete!<CR>:call system('chmod 777 $HOME/dotfile/clipboard.txt')<CR>:redraw!<CR>gv

" Ctrl X - Cut
nnoremap <silent> <C-x>           :call SavePos()<CR>:w! $HOME/dotfile/clipboard.txt<CR>dd:call system('chmod 777 $HOME/dotfile/clipboard.txt')<CR>:call setpos(".", b:savepos)<CR>
inoremap <silent> <C-x> <C-\><C-o>:call SavePos()<CR><ESC>:w! $HOME/dotfile/clipboard.txt<CR>dd:call system('chmod 777 $HOME/dotfile/clipboard.txt')<CR>:call setpos(".", b:savepos)<CR><C-g>u
vnoremap <silent> <C-x> d<ESC>:call delete(expand("$HOME/dotfile/clipboard.txt"))<CR>:new $HOME/dotfile/clipboard.txt<CR>P:w!<CR>:bdelete!<CR>:call system('chmod 777 $HOME/dotfile/clipboard.txt')<CR>

" Ctrl V - Paste from vim clipboard
inoremap <silent> <C-v> <C-o>:normal! gP<CR><C-g>u
nnoremap <silent> <C-v> gPi<C-g>u
vnoremap <silent> <C-v> "_dgP
if has('clipboard')
  cnoremap <C-v> <C-r>+
else
  cnoremap <C-v> <C-r>"
endif

" Insert - Paste
nnoremap <silent> <Insert>            :r $HOME/dotfile/clipboard.txt<CR>
inoremap <silent> <Insert> <C-g>u<ESC>:r $HOME/dotfile/clipboard.txt<CR>i<C-g>u
vnoremap <silent> <Insert>           "_d:r $HOME/dotfile/clipboard.txt<CR>
cnoremap <Insert> <C-r>"

" Ctrl S - Save
nnoremap <silent> <C-s> :call MySave()<CR>
inoremap <silent> <C-s> <C-g>u<C-O>:call MySave()<CR>
vnoremap <silent> <C-s> <ESC>:call MySave()<CR>
cnoremap <C-s> <C-c>:call MySave()<CR>

" Home - Go To Begin of the Line
call CreateShortcut("Home", "^", "inv")

" End - Go To End of the Line
call CreateShortcut("End", "$l", "inv")

" Ctrl K - Delete Line
nnoremap <silent> <C-k> :call DeleteLine()<CR>
inoremap <silent> <C-k> <C-o>:call DeleteLine()<CR><C-g>u
vnoremap <silent> <C-k> :d _<CR>

" Ctrl D - Duplicate Line
try
  nnoremap <silent> <C-d> mj:t.<CR>`jj
  inoremap <silent> <C-d> <C-\><C-O>mj<C-O>:t.<CR><C-O>`j<Down><C-g>u
  vnoremap <C-d> yPgv
catch /:E20:/
  " mark not set error
  echon "Mark not set, Try again"
endtry

" Ctrl Q - Visual block selection
nnoremap <C-q> <C-v>
inoremap <C-q> <C-\><C-o><C-v>
vnoremap <C-q> <ESC>

" Ctrl Left - Move a word
call CreateShortcut("C-Left", "b", "n")

" Ctrl Right - Move a word
call CreateShortcut("C-Right", "w", "n")

" Ctrl Up - Pageup, &scroll = half of screen lines
execute 'nnoremap <silent> <C-Up> '.g:vertical_jump.'k'
execute 'inoremap <silent> <C-Up> <C-\><C-O>'.g:vertical_jump.'k'
execute 'vnoremap <silent> <C-Up> '.g:vertical_jump.'k'

" Ctrl Down - Pagedown
execute 'nnoremap <silent> <C-Down> '.g:vertical_jump.'j'
execute 'inoremap <silent> <C-Down> <C-\><C-O>'.g:vertical_jump.'j'
execute 'vnoremap <silent> <C-Down> '.g:vertical_jump.'j'

" Ctrl U - Pageup
execute 'nnoremap <silent> <C-u> '.g:vertical_jump.'k'
execute 'inoremap <silent> <C-u> <C-\><C-O>'.g:vertical_jump.'k'
execute 'vnoremap <silent> <C-u> '.g:vertical_jump.'k'

" Ctrl J - Pagedown
execute 'nnoremap <silent> <C-j> '.g:vertical_jump.'j'
execute 'inoremap <silent> <C-j> <C-\><C-O>'.g:vertical_jump.'j'
execute 'vnoremap <silent> <C-j> '.g:vertical_jump.'j'

" Ctrl F - Find
nnoremap <C-f> :noh<CR>:set noignorecase<CR>/\c
inoremap <C-f> <Esc>:noh<CR>:set noignorecase<CR>/\c
vnoremap <C-f> <Esc>:noh<CR>:set noignorecase<CR>/\%V\c

" Ctrl R - Search and Replace
nnoremap <C-r> :noh<CR>:set noignorecase<CR>:%s/
inoremap <C-r> <Esc>:noh<CR>:set noignorecase<CR>:%s/
vnoremap <C-r> <Esc>:noh<CR>:set noignorecase<CR>:'<,'>s/\%V

" Ctrl G - Select all
call CreateShortcut("C-g", "ggVG", "inv")

" Ctrl L - Visual line selection
call CreateShortcut("C-l", "V", "n")
inoremap <C-l> <C-\><C-O>V
vnoremap <C-l> <ESC>

" Pageup - Move up Line
nnoremap <silent> <PageUp> mj:<C-u>silent! move-2<CR>`j
inoremap <silent> <PageUp> <C-\><C-O>mj<C-O>:<C-u>silent! move-2<CR><C-O>`j<C-g>u
vnoremap <silent> <PageUp> :<C-u>silent! '<,'>move-2<CR>gv

" Pagedown - Move down Line
nnoremap <silent> <PageDown> mj:<C-u>silent! move+<CR>`j
inoremap <silent> <PageDown> <C-\><C-O>mj<C-O>:<C-u>silent! move+<CR><C-O>`j<C-g>u
vnoremap <silent> <PageDown> :<C-u>silent! '<,'>move'>+<CR>gv

" Ctrl Pageup - Move up Line booster
nnoremap <silent> <C-PageUp> mj:<C-u>silent! move-16<CR>`j
inoremap <silent> <C-PageUp> <C-\><C-O>mj<C-O>:<C-u>silent! move-16<CR><C-O>`j<C-g>u
vnoremap <silent> <C-PageUp> :<C-u>silent! '<,'>move-16<CR>gv

" Ctrl Pagedown - Move down Line boosted
nnoremap <silent> <C-PageDown> mj:<C-u>silent! move+15<CR>`j
inoremap <silent> <C-PageDown> <C-\><C-O>mj<C-O>:<C-u>silent! move+15<CR><C-O>`j<C-g>u
vnoremap <silent> <C-PageDown> :<C-u>silent! '<,'>move'>+15<CR>gv

" Ctrl W - Quit
nnoremap <silent> <C-w> :call MyQuit()<CR>
inoremap <silent> <C-w> <C-o>:call MyQuit()<CR>
vnoremap <silent> <C-w> <ESC>:call MyQuit()<CR>
cnoremap <C-w> <C-c>:call MyQuit()<CR>

" Tab - Indent
call CreateShortcut("Tab", ">>", "n")
call CreateShortcut("Tab", ">", "v", "restoreSelectionAfter")

" Shift Tab - UnIndent
call CreateShortcut("S-Tab", "<<", "in")
call CreateShortcut("S-Tab", "<", "v", "restoreSelectionAfter")

" Ctrl Z - Undo
nnoremap <C-z> u
inoremap <C-z> <C-o>u
vnoremap <C-z> <ESC>u
cnoremap <C-z> <C-c>u

" Ctrl Y - Redo
nnoremap <C-y> <C-r>
inoremap <C-y> <C-o><C-r>
cnoremap <C-y> <C-c><C-r>

" Ctrl T - New tab
call CreateShortcut("C-t", ":tabnew<CR>", "inv", "noTrailingIInInsert", "cmdInVisual")

" Ctrl N - Next word
call CreateShortcut("C-n", "w", "n")
inoremap <C-n> <C-Right>
vnoremap <C-n> 5l

" Terminal Alt Backspace kill a word
nnoremap <Esc><BS> "_dBi<C-g>u
inoremap <Esc><BS> <C-w><C-g>u
vnoremap <Esc><BS> "_di<C-g>u
cnoremap <Esc><BS> <C-w>

" Terminal Alt Right - Next word
" execute "set <M-C>=\e[1;3C"
nnoremap <ESC><ESC>OC w
inoremap <ESC><ESC>OC <C-Right>
cnoremap <ESC><ESC>OC <C-Right>
vnoremap <ESC><ESC>OC 5l
nnoremap <ESC>[1;3C w
inoremap <ESC>[1;3C <C-Right>
cnoremap <ESC>[1;3C <C-Right>
vnoremap <ESC>[1;3C 5l
nnoremap <ESC><ESC>[C w
inoremap <ESC><ESC>[C <C-Right>
cnoremap <ESC><ESC>[C <C-Right>
vnoremap <ESC><ESC>[C 5l
nnoremap <ESC>[1;5C w
inoremap <ESC>[1;5C <C-Right>
cnoremap <ESC>[1;5C <C-Right>
vnoremap <ESC>[1;5C 5l
nnoremap <ESC>[1;9C w
inoremap <ESC>[1;9C <C-Right>
cnoremap <ESC>[1;9C <C-Right>
vnoremap <ESC>[1;9C 5l

" Ctrl P - Previous word
call CreateShortcut("C-p", "b", "n")
inoremap <C-p> <C-Left>
vnoremap <C-p> 5h

" Terminal Alt Left - Previous word
" execute "set <M-D>=\e[1;3D"
nnoremap <ESC><ESC>OD b
inoremap <ESC><ESC>OD <C-Left>
cnoremap <ESC><ESC>OD <C-Left>
vnoremap <ESC><ESC>OD 5h
nnoremap <ESC>[1;3D b
inoremap <ESC>[1;3D <C-Left>
cnoremap <ESC>[1;3D <C-Left>
vnoremap <ESC>[1;3D 5h
nnoremap <ESC><ESC>[D b
inoremap <ESC><ESC>[D <C-Left>
cnoremap <ESC><ESC>[D <C-Left>
vnoremap <ESC><ESC>[D 5h
nnoremap <ESC>[1;5D b
inoremap <ESC>[1;5D <C-Left>
cnoremap <ESC>[1;5D <C-Left>
vnoremap <ESC>[1;5D 5h
nnoremap <ESC>[1;9D b
inoremap <ESC>[1;9D <C-Left>
cnoremap <ESC>[1;9D <C-Left>
vnoremap <ESC>[1;9D 5h

" Terminal Alt Up - Multiple UP keys
execute 'nnoremap <silent> <ESC><ESC>OA '.g:vertical_jump.'k'
execute 'inoremap <silent> <ESC><ESC>OA <C-\><C-O>'.g:vertical_jump.'k'
execute 'vnoremap <silent> <ESC><ESC>OA '.g:vertical_jump.'k'
execute 'nnoremap <silent> <ESC>[1;3A '.g:vertical_jump.'k'
execute 'inoremap <silent> <ESC>[1;3A <C-\><C-O>'.g:vertical_jump.'k'
execute 'vnoremap <silent> <ESC>[1;3A '.g:vertical_jump.'k'
execute 'nnoremap <silent> <ESC><ESC>[A '.g:vertical_jump.'k'
execute 'inoremap <silent> <ESC><ESC>[A <C-\><C-O>'.g:vertical_jump.'k'
execute 'vnoremap <silent> <ESC><ESC>[A '.g:vertical_jump.'k'
execute 'nnoremap <silent> <ESC>[1;5A '.g:vertical_jump.'k'
execute 'inoremap <silent> <ESC>[1;5A <C-\><C-O>'.g:vertical_jump.'k'
execute 'vnoremap <silent> <ESC>[1;5A '.g:vertical_jump.'k'
execute 'nnoremap <silent> <ESC>[1;9A '.g:vertical_jump.'k'
execute 'inoremap <silent> <ESC>[1;9A <C-\><C-O>'.g:vertical_jump.'k'
execute 'vnoremap <silent> <ESC>[1;9A '.g:vertical_jump.'k'

" Terminal Alt Down - Multiple DOWN keys
execute 'nnoremap <silent> <ESC><ESC>OB '.g:vertical_jump.'j'
execute 'inoremap <silent> <ESC><ESC>OB <C-\><C-O>'.g:vertical_jump.'j'
execute 'vnoremap <silent> <ESC><ESC>OB '.g:vertical_jump.'j'
execute 'nnoremap <silent> <ESC>[1;3B '.g:vertical_jump.'j'
execute 'inoremap <silent> <ESC>[1;3B <C-\><C-O>'.g:vertical_jump.'j'
execute 'vnoremap <silent> <ESC>[1;3B '.g:vertical_jump.'j'
execute 'nnoremap <silent> <ESC><ESC>[B '.g:vertical_jump.'j'
execute 'inoremap <silent> <ESC><ESC>[B <C-\><C-O>'.g:vertical_jump.'j'
execute 'vnoremap <silent> <ESC><ESC>[B '.g:vertical_jump.'j'
execute 'nnoremap <silent> <ESC>[1;5B '.g:vertical_jump.'j'
execute 'inoremap <silent> <ESC>[1;5B <C-\><C-O>'.g:vertical_jump.'j'
execute 'vnoremap <silent> <ESC>[1;5B '.g:vertical_jump.'j'
execute 'nnoremap <silent> <ESC>[1;9B '.g:vertical_jump.'j'
execute 'inoremap <silent> <ESC>[1;9B <C-\><C-O>'.g:vertical_jump.'j'
execute 'vnoremap <silent> <ESC>[1;9B '.g:vertical_jump.'j'

" Ctrl Left - Previous 5 column
vnoremap <C-Left> 5h

" Ctrl Right - Next 5 column
vnoremap <C-Right> 5l

" Ctrl O - Netrw (:Explore)
call CreateShortcut("C-o",":call OpenNetrw()<CR>", "inv", "noTrailingIInInsert", "cmdInVisual")

" Byobu key binding
call CreateShortcut("F2", ":tabnew<CR>", "inv")
call CreateShortcut("F3", ":tabp<CR>", "inv")
call CreateShortcut("F4", ":tabn<CR>", "inv")

" Ctrl \ is toggling comments
nnoremap <silent> <C-\> :call ToggleComment()<CR>
inoremap <silent> <C-\> <C-o>:call ToggleComment()<CR>
vnoremap <silent> <C-\> :call ToggleComment()<CR>

inoremap <C-b> <C-w>
nnoremap <C-b> i<C-w>
cnoremap <C-b> <C-w>
nnoremap <Del> i<Del>

" minus key is folding/unfolding code
nnoremap - zi

" Useful command mode mapping
cnoremap <C-k> <C-e><C-u>
cnoremap <C-f> <C-c>:noh<CR>/\c
cnoremap <C-r> <C-c>:noh<CR>:%s/
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

""" Case insensitive when entering command mode
nnoremap : :set ignorecase<CR>:
nnoremap / :set ignorecase<CR>/

inoremap <C-CR> <ESC>o<C-g>u
nnoremap <C-CR> o<C-g>u
inoremap <C-BS> <C-g>u<C-W>
nnoremap <C-BS> i<C-g>u<C-W>
cnoremap <C-BS> <C-w>
inoremap <C-_> <C-W><C-g>u
nnoremap <C-_> i<C-W><C-g>u
cnoremap <C-_> <C-w>
vnoremap <bar> I
vnoremap <Space> "_di<Space><C-g>u
vnoremap <CR> "_di<CR><C-g>u
vnoremap <BS> "_di<C-g>u

vnoremap <silent> ( <ESC>:call WrapSelection("(",")")<CR>
vnoremap <silent> [ <ESC>:call WrapSelection("[","]")<CR>
vnoremap <silent> { <ESC>:call WrapSelection("{","}")<CR>
vnoremap <silent> ) <ESC>:call WrapSelection("(",")")<CR>
vnoremap <silent> ] <ESC>:call WrapSelection("[","]")<CR>
vnoremap <silent> } <ESC>:call WrapSelection("{","}")<CR>
vnoremap <silent> ' <ESC>:call WrapSelection("'","'")<CR>
vnoremap <silent> " <ESC>:call WrapSelection("\"","\"")<CR>
vnoremap <silent> < <ESC>:call WrapSelection("<",">")<CR>
vnoremap <silent> > <ESC>:call WrapSelection("<",">")<CR>
vnoremap <silent> / <ESC>:call WrapSelection("/","/")<CR>
vnoremap <silent> \ <ESC>:call WrapSelection("\\","\\")<CR>
inoremap {<CR> {<CR>}<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap (<CR> (<CR>)<ESC>O

function! WrapSelection(c1, c2)
  execute "normal! `<i".a:c1
  execute "normal! `>a".a:c2
  normal! l
endfunction

" Commenting blocks of code.
autocmd FileType c,cpp,java         let b:comment_leader = '\/\/'
autocmd FileType javascript         let b:comment_leader = '\/\/'
autocmd FileType arduino            let b:comment_leader = '\/\/'
autocmd FileType registry           let b:comment_leader = ';'
autocmd FileType dosbatch           let b:comment_leader = '::'
autocmd FileType sh,ruby,python     let b:comment_leader = '#'
autocmd FileType conf,fstab         let b:comment_leader = '#'
autocmd FileType tmux,zsh           let b:comment_leader = '#'
autocmd FileType make,cmake,yaml    let b:comment_leader = '#'
autocmd FileType debsources,desktop let b:comment_leader = '#'
autocmd FileType xdefaults          let b:comment_leader = '#'
autocmd FileType dockerfile         let b:comment_leader = '#'
autocmd FileType matlab,tex         let b:comment_leader = '%'
autocmd FileType vim                let b:comment_leader = '"'
autocmd FileType css                let b:comment_leader = '\/\*'   |   let b:comment_ender = '\*\/'
autocmd FileType html,xml,markdown  let b:comment_leader = '<!--'   |   let b:comment_ender = '-->'

function! ToggleComment()
  if exists('b:comment_leader')
    if getline(".") =~ '^' . b:comment_leader
      " Uncomment the line
      execute 'silent s/^' . b:comment_leader .'\( \)\?//g'
      if exists('b:comment_ender')
        execute 'silent s/ ' . b:comment_ender .'$//g'
      endif
    elseif getline(".") =~ '^\s*$'
      " Empty lines: ignore
    else
      " Comment the line
      execute 'silent s/^/' . b:comment_leader .' /g'
      if exists('b:comment_ender')
        execute 'silent s/$/\ ' . b:comment_ender .'/g'
      endif
    endif
  else
    echom "Unknow comment's symbols for filetype"
  endif
endfunction

" autocmd Filetype * setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType * exe 'setlocal dictionary+=$VIMRUNTIME/syntax/'.&filetype.'.vim'
set completeopt=menuone
set complete=.,w,b
set complete+=k " Rescan files in the 'dictionary' option
if v:version > 704 || has("patch314") || has('patch-7.4.314')
  set shortmess+=c
endif
let autocomp=1
let g:CharSet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
inoremap <silent> <F10> <C-\><C-O>:call ToggleAutoComplete()<CR>
vnoremap <silent> <F10> <ESC>:call ToggleAutoComplete()<CR>
nnoremap <silent> <F10>      :call ToggleAutoComplete()<CR>
inoremap <expr> <Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <ESC>  pumvisible() ? "\<C-e>\<C-g>u" : "\<ESC>"
inoremap <ESC>A <Up>
inoremap <ESC>B <Down>
inoremap <ESC>C <Right>
inoremap <ESC>D <Left>

function! ToggleAutoComplete()
  if g:autocomp
    for l:char in split(g:CharSet, '\zs')
      silent execute "inoremap <silent> <expr> ".l:char." pumvisible() ? '".l:char."' : '".l:char."\<C-n>\<C-p>'"
    endfor
  else
    for l:char in split(g:CharSet, '\zs')
      execute "inoremap ".l:char." ".l:char
    endfor
  endif
  let g:autocomp=g:autocomp ? 0 : 1
endfunction
execute "call ToggleAutoComplete()"

let g:netrw_banner=0 " Hide banner
" let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' " Hide hidden files
autocmd FileType netrw call KeysInNetrw()
function! KeysInNetrw() " Map keys in file explorer
  " Right to enter
  nmap <buffer> <Right> <CR>
  " Left to go up
  nmap <buffer> <Left> -
  " l - Display info
  nmap <buffer> l qf
  " C-k - Delete files/directories
  nmap <buffer> <C-k> D
  vmap <buffer> <C-k> D
  " v - Enter to visual mode to select files
  nmap <buffer> v V
  " Backspace - go back
  nmap <buffer> <BS> u
  " Space to enter
  nmap <buffer> <Space> <CR>
  " Tab to go down an entry
  nmap <buffer> <Tab> j
endfunction

""" Custom commands

" :UndoCloseTab - To undo close tab
command! UndoCloseTab call OpenLastBufferInNewTab()

""" Colors and Statusline

let defaultAccentColor=161
let colorsAndModes= {
  \ 'i' : 39,
  \ 'v' : 82,
  \ 'V' : 226,
  \ '' : 208
\}
let defaultAccentColorGui='#d7005f'
let colorsAndModesGui= {
  \ 'i' : '#00afff',
  \ 'v' : '#5fff00',
  \ 'V' : '#ffff00',
  \ '' : '#ff8700'
\}
function! LastAccentColor()
  if !exists('b:lastMode') | let b:lastMode = mode() | call ChangeAccentColor() | endif
  if b:lastMode != mode()
    let b:lastMode = mode()
    call ChangeAccentColor()
  endif
  return ''
endfunction
function! ChangeAccentColor()
  let accentColor=get(g:colorsAndModes, mode(), g:defaultAccentColor)
  let accentColorGui=get(g:colorsAndModesGui, mode(), g:defaultAccentColorGui)
  execute 'hi User1 ctermfg=0 guifg=#000000 ctermbg=' . accentColor . ' guibg=' . accentColorGui
  execute 'hi User2 ctermbg=0 guibg=#2e3436 ctermfg=' . accentColor . ' guifg=' . accentColorGui
  execute 'hi User3 ctermfg=0 guifg=#000000 cterm=none gui=none ctermbg=' . accentColor . ' guibg=' . accentColorGui
  execute 'hi TabLineSel ctermfg=0 cterm=none ctermbg=' . accentColor
  execute 'hi TabLine ctermbg=0 ctermfg=' . accentColor
  execute 'hi CursorLineNr ctermfg=' . accentColor . ' guifg=' . accentColorGui
  return ''
endfunction
function! SearchCount()
  " variable b:lastKey = [key, Nth, N]
  if !exists('b:lastKey') | let b:lastKey = [[], 0, 0] | endif
  return b:lastKey[1] . "/" . b:lastKey[2]
endfunction
function! UpdateSearch()
  let pos=getpos('.')
  let key=[@/, b:changedtick]

  let b:lastKey[0] = key

  redir => cnt
    silent exe '%s/' . key[0] . '//gne'
  redir END
  let b:lastKey[2] = str2nr(matchstr( cnt, '\d\+' ))

  redir => nth
    silent exe '0,.s/' . key[0] . '//gne'
  redir END

  let b:lastKey[1] = str2nr(matchstr( nth, '\d\+' ))
  call setpos('.', pos)
endfunction
function CommandAfterSearch()
  if getcmdtype() == '/'
    return "\<cr>:call UpdateSearch()\<cr>"
  else
    return "\<cr>"
  endif
endfunction
cnoremap <silent> <expr> <CR> CommandAfterSearch()
function NextSearch()
  let l:line = line(".")
  normal! n
  if l:line != line(".")
    let b:lastKey[1]=b:lastKey[1]+1 <= b:lastKey[2] ? b:lastKey[1]+1 : b:lastKey[1]+1-b:lastKey[2]
  endif
endfunction
function PreviousSearch()
  let l:line = line(".")
  normal! N
  if l:line != line(".")
    let b:lastKey[1]=b:lastKey[1]-1 > 0 ? b:lastKey[1]-1 : b:lastKey[1]-1+b:lastKey[2]
  endif
endfunction
nnoremap <silent> n :call NextSearch()<CR>
nnoremap <silent> N :call PreviousSearch()<CR>
function! ReadOnly()
  return (&readonly || !&modifiable) ? 'Read Only ' : ''
endfunction
"  Get all mode in :h mode()
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'N·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'ic' : 'Insert',
    \ 'ix' : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rc' : 'Replace',
    \ 'Rv' : 'VReplace',
    \ 'Rx' : 'Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
\}
set statusline=
set statusline+=%{LastAccentColor()}
set statusline+=%1*\ ***%{toupper(g:currentmode[mode()])}***\  " Current mode
set statusline+=%2*\ %<%F\  " Filepath
set statusline+=%2*\ [%{SearchCount()}] " Nth of N when searching
set statusline+=%2*\ %= " To the right
set statusline+=%2*\ %{toupper((&fenc!=''?&fenc:&enc))}\[%{&ff}] " Encoding & Fileformat
set statusline+=%2*\ [%{&filetype}] " Filetype
set statusline+=%2*\ %{ReadOnly()} " ReadOnly Flags
set statusline+=%1*\ \%l/%L(%P)-%c\  " Position

function SyntaxMonokai()
  " Speed up the redraw
  " au InsertLeave * call ChangeAccentColor()
  " au CursorHold * let &ro = &ro

  """" Color Scheme
  "" Modified from tomasr Molokai on Github
  " Red = #F92672, 161
  " Orange = #FD971F, 208
  " Yellow = #E6DB74, 144
  " Light Green = #A6E22E, 118
  " Green = #00AF00, 34
  " Blue = #66D9EF, 81
  " Purple = #AE81FF, 135
  " Gray = #7E8E91, 59

  syntax enable " Enable syntax highlights
  set background=dark
  highlight clear
  syntax reset
  set t_Co=256

  let g:is_bash=1 " Tell $VIMRUNTIME/syntax/sh.vim that I am using bash
  let python_highlight_all = 1 " Tell $VIMRUNTIME/syntax/python.vim to highlight all

  " Normal is the background color
  hi Normal ctermfg=252 ctermbg=233 cterm=NONE guifg=#F8F8F2 guibg=#1B1D1E gui=NONE
  " Visual is the selection color
  hi Visual ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00afff gui=NONE
  " Pmenu is the popup autocomplete color
  hi Pmenu ctermfg=39 ctermbg=255 cterm=NONE guifg=#00afff guibg=White
  hi PmenuSel ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00afff

  hi Green ctermfg=34 ctermbg=NONE cterm=NONE guifg=#00af00 guibg=NONE gui=NONE
  hi iGreen ctermfg=0 ctermbg=34 cterm=NONE guifg=#000000 guibg=#00af00 gui=NONE
  hi Search ctermfg=59 ctermbg=226 cterm=NONE guibg=yellow guifg=black

  hi Boolean              ctermfg=135     guifg=#AE81FF
  hi Character            ctermfg=144     guifg=#E6DB74
  hi ColorColumn          ctermbg=236     guibg=#232526
  hi Comment              ctermfg=59      guifg=#7E8E91
  hi Conditional          ctermfg=161     cterm=none      guifg=#F92672     gui=none
  hi Constant             ctermfg=135     cterm=none      guifg=#AE81FF     gui=none
  hi Cursor               ctermfg=16      ctermbg=253     guifg=#000000     guibg=#F8F8F0
  hi CursorColumn         ctermbg=236     guibg=#293739
  hi CursorLine           ctermbg=234     cterm=none      guibg=#293739
  hi CursorLineNr         ctermfg=208     cterm=none      guifg=#FD971F     gui=none
  hi Debug                ctermfg=225     cterm=none      guifg=#BCA3A3     gui=none
  hi Define               ctermfg=81      guifg=#66D9EF
  hi Delimiter            ctermfg=241     guifg=#8F8F8F
  hi DiffAdd              ctermbg=24      guibg=#13354A
  hi DiffChange           ctermfg=181     ctermbg=239     guifg=#89807D     guibg=#4C4745
  hi DiffDelete           ctermfg=162     ctermbg=53      guifg=#960050     guibg=#1E0010
  hi DiffText             ctermbg=102     cterm=none      guibg=#4C4745     gui=none
  hi Directory            ctermfg=81      cterm=none      guifg=#66D9EF     gui=none
  hi Error                ctermfg=255     ctermbg=196     guifg=#E6DB74     guibg=#ff3333
  hi ErrorMsg             ctermfg=199     ctermbg=16      cterm=none        guifg=#F92672       guibg=#232526     gui=none
  hi Exception            ctermfg=118     cterm=none      guifg=#A6E22E     gui=none
  hi Float                ctermfg=135     guifg=#AE81FF
  hi FoldColumn           ctermfg=67      ctermbg=16      guifg=#465457     guibg=#000000
  hi Folded               ctermfg=242     ctermbg=235     cterm=NONE        guifg=#7E8E91       guibg=#272822     gui=NONE
  hi Function             ctermfg=118     guifg=#A6E22E
  hi Identifier           ctermfg=208     cterm=none      guifg=#FD971F
  hi Ignore               ctermfg=244     ctermbg=232     guifg=#808080     guibg=bg
  hi Keyword              ctermfg=161     cterm=none      guifg=#F92672     gui=none
  hi Label                ctermfg=229     cterm=none      guifg=#E6DB74     gui=none
  hi LineNr               ctermfg=250     ctermbg=236     guifg=#465457     guibg=#232526
  hi Macro                ctermfg=193     guifg=#C4BE89   gui=none
  hi MatchParen           ctermfg=233     ctermbg=208     cterm=none        guifg=#000000       guibg=#FD971F     gui=none
  hi MoreMsg              ctermfg=229     guifg=#E6DB74
  hi NonText              ctermfg=59      guifg=#465457
  hi Number               ctermfg=135     guifg=#AE81FF
  hi Operator             ctermfg=161     guifg=#F92672
  hi PmenuSbar            ctermbg=232     guibg=#080808
  hi PmenuThumb           ctermfg=81      guifg=#66D9EF
  hi PreCondit            ctermfg=118     cterm=none      guifg=#A6E22E     gui=none
  hi PreProc              ctermfg=118     cterm=none      guifg=#A6E22E
  hi Question             ctermfg=81      guifg=#66D9EF
  hi Repeat               ctermfg=161     cterm=none      guifg=#F92672     gui=none
  hi SignColumn           ctermfg=118     ctermbg=235     guifg=#A6E22E     guibg=#232526
  hi Special              ctermfg=81      guifg=#66D9EF   guibg=bg          gui=none
  hi SpecialChar          ctermfg=161     cterm=none      guifg=#F92672     gui=none
  hi SpecialComment       ctermfg=245     cterm=none      guifg=#7E8E91     gui=none
  hi SpecialKey           ctermfg=81      guifg=#66D9EF   gui=none
  hi SpellBad             ctermbg=52      cterm=underline
  hi SpellCap             ctermbg=17      cterm=underline
  hi SpellLocal           ctermbg=17      cterm=underline
  hi Statement            ctermfg=161     cterm=none      guifg=#F92672     gui=none
  hi StatusLine           ctermfg=238     ctermbg=253     guifg=#455354     guibg=fg
  hi StatusLineNC         ctermfg=244     ctermbg=232     guifg=#808080     guibg=#080808
  hi StorageClass         ctermfg=208     guifg=#FD971F   gui=none
  hi String               ctermfg=144     guifg=#E6DB74
  hi Structure            ctermfg=81      guifg=#66D9EF
  hi TabLineFill          cterm=none      ctermbg=none    guifg=#1B1D1E     guibg=#1B1D1E
  hi Tag                  ctermfg=161     guifg=#F92672   gui=none
  hi Title                ctermfg=166     guifg=#ef5939
  hi Todo                 ctermfg=231     ctermbg=232     cterm=none        guifg=#FFFFFF       guibg=bg        gui=none
  hi Type                 ctermfg=81      cterm=none      guifg=#66D9EF     gui=none
  hi Typedef              ctermfg=81      guifg=#66D9EF
  hi Underlined           ctermfg=244     cterm=underline guifg=#808080     gui=underline
  hi VertSplit            ctermfg=244     ctermbg=232     cterm=none        guifg=#808080       guibg=#080808   gui=none
  hi WarningMsg           ctermfg=231     ctermbg=238     cterm=none        guifg=#FFFFFF       guibg=#333333   gui=none
  hi WildMenu             ctermfg=81      ctermbg=16      guifg=#66D9EF     guibg=#000000
  hi iCursor              guifg=#000000   guibg=#F8F8F0
endfunction

" :OpenDroppedFiles <Drop_Files_To_Vim>
function! OpenDroppedFiles(droppedFiles)
  execute "silent! argadd " . a:droppedFiles
  argdo set eventignore-=Syntax | tabedit
endfunction
command! -nargs=1 OpenDroppedFiles call OpenDroppedFiles(<f-args>)

if has("python")
python << EOF
import vim
import json
def FormatJSON(fmtlStart, fmtlEnd):
  fmtlStart = fmtlStart-1
  jsonStr = "\n".join(vim.current.buffer[fmtlStart:fmtlEnd])
  prettyJson = json.dumps(json.loads(jsonStr), sort_keys=False, indent=4, separators=(',', ': '), ensure_ascii=False)
  prettyJson = prettyJson.encode('utf8')
  vim.current.buffer[fmtlStart:fmtlEnd] = prettyJson.split('\n')
EOF
  " :'<,'>JsonBeautify
  command! -range=% JsonBeautify python FormatJSON(<line1>, <line2>)
  nnoremenu Edit.Json.Beautify(UTF8)  ggVG:<C-u>'<,'>JsonBeautify<CR>
  vnoremenu Edit.Json.Beautify(UTF8)  :<C-u>'<,'>JsonBeautify<CR>
else
  command! JsonBeautify %!python -m json.tool
  nnoremenu Edit.Json.Beautify(cANSI) :%!python -m json.tool<CR>
endif

function! JsonMinify()
  set filetype=json
  filetype indent on
  execute "%s/\\s\\+$//e"
  execute "%left"
  execute "%j!"
endfunction

nnoremenu Edit.Json.Minify    :call JsonMinify()<CR>
command! JsonMinify           call JsonMinify()

" XML pretty by vim
function! XmlBeautify()
  call XmlMinify()
  setlocal filetype=xml
  filetype indent on
  setlocal smartindent
  execute "%s/></>\\r</e"
  normal! gg=G
  " Recolor the file again
  setlocal filetype=xml
endfunction

function! XmlMinify()
  setlocal filetype=xml
  execute "%s/>\\s\\+</></e"
  execute "%s/\\s\\+$//e"
  execute "%left"
  execute "%j!"
endfunction

nnoremenu Edit.XML.Beautify   :call XmlBeautify()<CR>
nnoremenu Edit.XML.Minify     :call XmlMinify()<CR>
command! XmlBeautify    execute "call XmlBeautify()"
command! XmlMinify      execute "call XmlMinify()"

" xxd command alias
command! -range=% XXD <line1>,<line2>%!xxd

" Merge selected to one line
nnoremenu Edit.Merge\ to\ one\ line  :%left<CR>:%j!<CR>
vnoremenu Edit.Merge\ to\ one\ line  :%left<CR>gv:%j!<CR>
command! -range=% MergeToOneLine <line1>,<line2>%left | <line1>,<line2>%j!

" Remove something
nnoremenu Edit.Remove.Empty\ lines          :g/^$/d<CR>
nnoremenu Edit.Remove.Leading\ whitespace   :%s/^\s\+//e<CR>
nnoremenu Edit.Remove.Trailing\ whitespace  :%s/\s\+$//e<CR>

command! -range=% RemoveLeadingSpace     <line1>,<line2>%s/^\s\+//e
command! -range=% RemoveTrailingSpace    <line1>,<line2>%s/\s\+$//e
command! -range=% RemoveEmptyLines       <line1>,<line2>g/^$/d

" Toggle case
nnoremenu Edit.Toggle\ case.Upper          ggVGU
nnoremenu Edit.Toggle\ case.Lower          ggVGu
vnoremenu Edit.Toggle\ case.Upper          U
vnoremenu Edit.Toggle\ case.Lower          u
command! -range=% ToggleCaseToUpper  <line1>,<line2>s/\%V.*\%V./\U&/
command! -range=% ToggleCaseToLower  <line1>,<line2>s/\%V.*\%V./\L&/

" Opencc
nnoremenu Edit.Opencc.Traditional         :%!opencc -c s2twp.json<CR>
nnoremenu Edit.Opencc.Simplified          :%!opencc -c tw2sp.json<CR>

command! -range=% Opencc2T    <line1>,<line2>%!opencc -c s2twp.json
command! -range=% Opencc2S    <line1>,<line2>%!opencc -c tw2sp.json

" Fast rendering for current file
function! FastRender()
  setlocal nocursorline
  syntax clear
endfunction

noremenu Edit.FastRender :call FastRender()<CR>
command! FastRender call FastRender()

" Split view
noremenu Edit.Split\ Window.Vertical\ 2     :vsplit<CR>
noremenu Edit.Split\ Window.Vertical\ 3     :vsplit<CR>:vsplit<CR>:wincmd =<CR>
noremenu Edit.Split\ Window.Horizontal\ 2   :split<CR>
noremenu Edit.Split\ Window.Horizontal\ 3   :split<CR>:split<CR>:wincmd =<CR>

command! SplitVertical2   vsplit
command! SplitVertical3   vsplit | vsplit | wincmd =
command! SplitHorizontal2 split
command! SplitHorizontal3 split  | split  | wincmd =

" Indent format
function! IndentSpace(width)
  set expandtab
  execute "set tabstop=" . a:width
  execute "set shiftwidth=" . a:width
  execute "set softtabstop=" . a:width
  execute "%retab!"
endfunction

function! IndentTab(width)
  set noexpandtab
  set softtabstop=0
  execute "set tabstop=" . a:width
  execute "set shiftwidth=" . a:width
  execute "%retab!"
endfunction

command! IndentSpace2   execute "call IndentSpace(2)"
command! IndentSpace4   execute "call IndentSpace(4)"
command! IndentSpace8   execute "call IndentSpace(8)"
command! IndentTab2     execute "call IndentTab(2)"
command! IndentTab4     execute "call IndentTab(4)"
command! IndentTab8     execute "call IndentTab(8)"
noremenu Edit.Indent.Space\ 2   :call IndentSpace(2)<CR>
noremenu Edit.Indent.Space\ 4   :call IndentSpace(4)<CR>
noremenu Edit.Indent.Space\ 8   :call IndentSpace(8)<CR>
noremenu Edit.Indent.Tab\ 2     :call IndentTab(2)<CR>
noremenu Edit.Indent.Tab\ 4     :call IndentTab(4)<CR>
noremenu Edit.Indent.Tab\ 8     :call IndentTab(8)<CR>

" Line ending format
command! LineEndingUnix   execute "set fileformat=unix"
command! LineEndingDos    execute "set fileformat=dos"
command! LineEndingMac    execute "set fileformat=mac"
noremenu Edit.Line\ ending.Unix  :set fileformat=unix<CR>
noremenu Edit.Line\ ending.Dos   :set fileformat=dos<CR>
noremenu Edit.Line\ ending.Mac   :set fileformat=mac<CR>

" Encoding
noremenu Edit.Encoding.UTF8      :e ++enc=utf-8<CR>
noremenu Edit.Encoding.Big5      :e ++enc=big5<CR>
noremenu Edit.Encoding.GBK       :e ++enc=gbk<CR>
noremenu Edit.Encoding.Japan     :e ++enc=japan<CR>
noremenu Edit.Encoding.Korea     :e ++enc=korea<CR>
noremenu Edit.Encoding.UTF16LE   :e ++enc=utf-16le<CR>
noremenu Edit.Encoding.UTF16BE   :e ++enc=utf-16be<CR>
noremenu Edit.Encoding.ANSI      :e ++enc=ansi<CR>

command! EncodingUTF8    execute "e ++enc=utf-8"
command! EncodingBig5    execute "e ++enc=big5"
command! EncodingGBK     execute "e ++enc=gbk"
command! EncodingJapan   execute "e ++enc=japan"
command! EncodingKorea   execute "e ++enc=korea"
command! EncodingUTF16LE execute "e ++enc=utf-16le"
command! EncodingUTF16BE execute "e ++enc=utf-16be"
command! EncodingAnsi    execute "e ++enc=ansi"

if !exists('g:ftypes') | let g:ftypes = map(split(globpath(&rtp, 'syntax/*.vim'), '\n'), 'fnamemodify(v:val, ":t:r")') | endif
for syn in g:ftypes
  execute "noremenu Edit.Filetype.".split(syn, '\zs')[0].".".syn." :setlocal filetype=".syn."<CR>"
endfor

" Get into insert mode by pressing any key in visual mode
for b:char in split(g:CharSet, '\zs')
  execute "vnoremap ".b:char." \"_di<C-g>u".b:char
endfor

autocmd BufRead,BufNewFile,BufWritePost,BufEnter,FileType * call HighlightGlobal()
autocmd BufRead,BufNewFile,BufWritePost *.{srt,SRT,vtt,VTT} call HighlightSRT()
autocmd BufRead,BufNewFile,BufWritePost *.{ass,ASS,ssa,SSA} call HighlightASS()
autocmd BufRead,BufNewFile,BufWritePost *.{ps1,PS1,psd1,PSD1,psm1,PSM1,pssc,PSSC} call HighlightPS1()
autocmd FileType c,cpp,javascript,python,cs,go call HighlightC()

function! HighlightGlobal()
  if &filetype == "" || &filetype == "text"
    syn match alphanumeric  "[A-Za-z0-9_]"
    " Copy from $VIM/syntax/lua.vim
    " integer number
    syn match txtNumber     "\<\d\+\>"
    " floating point number, with dot, optional exponent
    syn match txtNumber     "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
    " floating point number, starting with a dot, optional exponent
    syn match txtNumber     "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
    " floating point number, without dot, with exponent
    syn match txtNumber     "\<\d\+[eE][-+]\=\d\+\>"
    " Wide characters and non-ascii characters
    syn match nonalphabet   "[\u0021-\u002F]"
    syn match nonalphabet   "[\u003A-\u0040]"
    syn match nonalphabet   "[\u005B-\u0060]"
    syn match nonalphabet   "[\u007B-\u007E]"
    syn match nonalphabet   "[^\u0000-\u007F]"
    syn match lineURL       "\(https\?\|ftps\?\|git\|ssh\):\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*"
    hi def link alphanumeric  Function
    hi def link txtNumber	    Define
    hi def link lineURL	      Green
    hi def link nonalphabet   Conditional
  endif
endfunction

function! HighlightSRT()
  setlocal filetype=srt
  syn case ignore
  syn match srtContent ".*"
  syn match srtArrow "-->"
  syn match srtComment "^#.*"
  syn match srtError "\[br\]"
  syn match srtError "{y:[bi][bi]}"
  syn match srtError "{y:[bi]}"
  syn match srtNumber "^[0-9]\+\s*$"
  syn region transparent matchgroup=srtTime start='[0-9: ]\+[\., ][0-9 ]*' end='[0-9: ]\+[\., ][0-9 ]*' contains=srtArrow oneline

  hi def link srtArrow      Type
  hi def link srtComment    Comment
  hi def link srtContent    Identifier
  hi def link srtError      Error
  hi def link srtNumber     Number
  hi def link srtTime       Statement
endfunction

function! HighlightASS()
  setlocal filetype=ass
  syn match assSection       "^\[.*\]"
  syn match assSourceComment "^;.*$"
  syn match assLine          "^[^;][^:]*:.*$"  contains=assHeader,assComment,assDialog
  syn match assHeader        "^[^;][^:]*:\s*"  contained nextgroup=assHeaderText
  syn match assHeaderText    ".*$"             contained
  syn match assComment       "^Comment:\s*"    contained nextgroup=assCommentText
  syn match assCommentText   ".*$"             contained
  syn match assDialog        "^Dialogue:\s*"   contained nextgroup=assDialogTimes
  syn match assDialogTimes   "\([^,]*,\)\{4}"  contained nextgroup=assDialogActor
  syn match assDialogActor   "[^,]*"           contained nextgroup=assDialogEffects
  syn match assDialogEffects ",\([^,]*,\)\{4}" contained nextgroup=assDialogText
  syn match assDialogText    ".*$"             contained contains=assTextComment,assTextSubCode
  syn match assTextComment   "{[^}]*}"         contained
  syn match assTextSubCode   "{\\[^}]*}"       contained

  hi def link assSection         Function
  hi def link assSourceComment   Comment
  hi def link assHeader          Statement
  hi def link assComment         Statement
  hi def link assDialog          Statement
  hi def link assHeaderText      Constant
  hi def link assCommentText     Comment
  hi def link assDialogTimes     Type
  hi def link assDialogActor     Title
  hi def link assDialogEffects   Function
  hi def link assDialogText      Identifier
  hi def link assTextComment     Comment
  hi def link assTextSubCode     Comment
endfunction

function! HighlightPS1()
  " Project Repository: https://github.com/PProvost/vim-ps1
  set ft=ps1
  syn case ignore
  syn cluster ps1NotTop contains=@ps1Comment,ps1CDocParam,ps1FunctionDeclaration
  syn keyword ps1CommentTodo TODO FIXME XXX TBD HACK NOTE contained
  syn match ps1CDocParam /.*/ contained
  syn match ps1CommentDoc /^\s*\zs\.\w\+\>/ nextgroup=ps1CDocParam contained
  syn match ps1CommentDoc /#\s*\zs\.\w\+\>/ nextgroup=ps1CDocParam contained
  syn match ps1Comment /#.*/ contains=ps1CommentTodo,ps1CommentDoc,@Spell
  syn region ps1Comment start="<#" end="#>" contains=ps1CommentTodo,ps1CommentDoc,@Spell
  syn keyword ps1Conditional if else elseif switch default
  syn keyword ps1Repeat while for do until break continue foreach in
  syn match ps1Repeat /\<foreach\>/ nextgroup=ps1Block skipwhite
  syn match ps1Keyword /\<while\>/ nextgroup=ps1Block skipwhite
  syn match ps1Keyword /\<where\>/ nextgroup=ps1Block skipwhite
  syn keyword ps1Exception begin process end exit inlinescript parallel sequence
  syn keyword ps1Keyword try catch finally throw
  syn keyword ps1Keyword return filter in trap param data dynamicparam
  syn keyword ps1Constant $true $false $null
  syn match ps1Constant +\$?+
  syn match ps1Constant +\$_+
  syn match ps1Constant +\$\$+
  syn match ps1Constant +\$^+
  syn keyword ps1Keyword class define from using var
  syn keyword ps1Keyword function nextgroup=ps1FunctionDeclaration skipwhite
  syn keyword ps1Keyword filter nextgroup=ps1FunctionDeclaration skipwhite
  syn keyword ps1Keyword workflow nextgroup=ps1FunctionDeclaration skipwhite
  syn keyword ps1Keyword configuration nextgroup=ps1FunctionDeclaration skipwhite
  syn keyword ps1Keyword class nextgroup=ps1FunctionDeclaration skipwhite
  syn keyword ps1Keyword enum nextgroup=ps1FunctionDeclaration skipwhite
  syn match ps1FunctionDeclaration /\w\+\(-\w\+\)*/ contained
  syn match ps1FunctionInvocation /\w\+\(-\w\+\)\+/
  syn match ps1Type /\[[a-z_][a-z0-9_.,\[\]]\+\]/
  syn match ps1ScopeModifier /\(global:\|local:\|private:\|script:\)/ contained
  syn match ps1Variable /\$\w\+\(:\w\+\)\?/ contains=ps1ScopeModifier
  syn match ps1Variable /\${\w\+\(:\w\+\)\?}/ contains=ps1ScopeModifier
  syn keyword ps1Operator -eq -ne -ge -gt -lt -le -like -notlike -match -notmatch -replace -split -contains -notcontains
  syn keyword ps1Operator -ieq -ine -ige -igt -ile -ilt -ilike -inotlike -imatch -inotmatch -ireplace -isplit -icontains -inotcontains
  syn keyword ps1Operator -ceq -cne -cge -cgt -clt -cle -clike -cnotlike -cmatch -cnotmatch -creplace -csplit -ccontains -cnotcontains
  syn keyword ps1Operator -in -notin
  syn keyword ps1Operator -is -isnot -as -join
  syn keyword ps1Operator -and -or -not -xor -band -bor -bnot -bxor
  syn keyword ps1Operator -f
  syn match ps1Operator /!/
  syn match ps1Operator /=/
  syn match ps1Operator /+=/
  syn match ps1Operator /-=/
  syn match ps1Operator /\*=/
  syn match ps1Operator /\/=/
  syn match ps1Operator /%=/
  syn match ps1Operator /+/
  syn match ps1Operator /-\(\s\|\d\|\.\|\$\|(\)\@=/
  syn match ps1Operator /\*/
  syn match ps1Operator /\//
  syn match ps1Operator /|/
  syn match ps1Operator /%/
  syn match ps1Operator /&/
  syn match ps1Operator /::/
  syn match ps1Operator /,/
  syn match ps1Operator /\(^\|\s\)\@<=\. \@=/
  syn region ps1String start=/"/ skip=/`"/ end=/"/ contains=@ps1StringSpecial,@Spell
  syn region ps1String start=/'/ skip=/''/ end=/'/
  syn region ps1String start=/@"$/ end=/^"@/ contains=@ps1StringSpecial,@Spell
  syn region ps1String start=/@'$/ end=/^'@/
  syn match ps1Escape /`./
  syn region ps1Interpolation matchgroup=ps1InterpolationDelimiter start="$(" end=")" contained contains=ALLBUT,@ps1NotTop
  syn region ps1NestedParentheses start="(" skip="\\\\\|\\)" matchgroup=ps1Interpolation end=")" transparent contained
  syn cluster ps1StringSpecial contains=ps1Escape,ps1Interpolation,ps1Variable,ps1Boolean,ps1Constant,ps1BuiltIn,@Spell
  syn match   ps1Number		"\(\<\|-\)\@<=\(0[xX]\x\+\|\d\+\)\([KMGTP][B]\)\=\(\>\|-\)\@="
  syn match   ps1Number		"\(\(\<\|-\)\@<=\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[dD]\="
  syn match   ps1Number		"\<\d\+[eE][-+]\=\d\+[dD]\=\>"
  syn match   ps1Number		"\<\d\+\([eE][-+]\=\d\+\)\=[dD]\>"
  syn match ps1Boolean "$\%(true\|false\)\>"
  syn match ps1Constant /\$null\>/
  syn match ps1BuiltIn "$^\|$?\|$_\|$\$"
  syn match ps1BuiltIn "$\%(args\|error\|foreach\|home\|input\)\>"
  syn match ps1BuiltIn "$\%(match\(es\)\?\|myinvocation\|host\|lastexitcode\)\>"
  syn match ps1BuiltIn "$\%(ofs\|shellid\|stacktrace\)\>"

	hi def link ps1Number Number
	hi def link ps1Block Block
	hi def link ps1Region Region
	hi def link ps1Exception Exception
	hi def link ps1Constant Constant
	hi def link ps1String String
	hi def link ps1Escape SpecialChar
	hi def link ps1InterpolationDelimiter Delimiter
	hi def link ps1Conditional Conditional
	hi def link ps1FunctionDeclaration Function
	hi def link ps1FunctionInvocation Function
	hi def link ps1Variable Identifier
	hi def link ps1Boolean Boolean
	hi def link ps1Constant Constant
	hi def link ps1BuiltIn StorageClass
	hi def link ps1Type Type
	hi def link ps1ScopeModifier StorageClass
	hi def link ps1Comment Comment
	hi def link ps1CommentTodo Todo
	hi def link ps1CommentDoc Tag
	hi def link ps1CDocParam Todo
	hi def link ps1Operator Operator
	hi def link ps1Repeat Repeat
	hi def link ps1RepeatAndCmdlet Repeat
	hi def link ps1Keyword Keyword
	hi def link ps1KeywordAndCmdlet Keyword
endfunction

function! HighlightC()
  syn match    cCustomParen    "(" contains=cParen,cCppParen
  syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
  syn match    cCustomScope    "::"
  syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope

  hi def link cCustomFunc  Define
  hi def link cCustomClass Define
endfunction

if has("gui_running")

  let g:guifontsize=13
  function! ChangeFontSize()
    if has('win32') || has('win64')
      execute "set guifont=Ubuntu\\ Mono:h".g:guifontsize.",Consolas:h".g:guifontsize
      execute "set guifontwide=DroidMono:h".g:guifontsize.",Inziu\\ Iosevka\\ TC:h".g:guifontsize.",NSimsun:h".g:guifontsize
    else
      execute "set guifont=Ubuntu\\ Mono\\ ".g:guifontsize
    endif
  endfunction
  call ChangeFontSize()

  nnoremap <silent> <Home> :let g:guifontsize+=1<CR>:call ChangeFontSize()<CR>
  nnoremap <silent> <End>  :let g:guifontsize-=1<CR>:call ChangeFontSize()<CR>

  " Restore all sessions, GUI only, don't do this with terminal vim
  function! MakeSession()
"     let bufferNum = len(filter(split(bufferActive, "\n"), 'strlen(v:val) == 0'))

    if has('win32') || has('win64')
      let mySession=expand("$TEMP/vim/session.vim")
    else
      let mySession=expand("$HOME/dotfile/.vim/session.vim")
    endif
    " Don's save the session if there is only one buffer
    if exists('g:bufferNum')
      if g:bufferNum <= 1 | call delete(mySession) | return | endif
    endif
    exe "mksession! " . mySession
  endfunction

  function! LoadSession()
    " Prevent screen flashing on start
    hi Normal ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E
    if has('win32') || has('win64')
      let mySession=expand("$TEMP/vim/session.vim")
    else
      let mySession=expand("$HOME/dotfile/.vim/session.vim")
   endif
    if (filereadable(mySession))
      exe 'source ' . mySession
    else
      echo "No session loaded."
    endif
  endfunction
  au VimEnter *  nested :call LoadSession() | call SyntaxMonokai()
  au VimLeave * :call MakeSession()

  if has('win32') || has('win64')
    call EnsureDirExists($TEMP."/vim/backup")
    call EnsureDirExists($TEMP."/vim/swap")
    call EnsureDirExists($TEMP."/vim/undo")
    set directory=$TEMP/vim/swap
    set backupdir=$TEMP/vim/backup
    set undodir=$TEMP/vim/undo
    au GUIEnter * simalt ~x " Full screen on start
  endif
  set number
  set lines=999 columns=999 " set window Maximized
  set scrolloff& " unset scroll values
  set sidescrolloff&
"   set clipboard& " unset clipboard
  set fileformats=dos,unix

  " Ctrl C is copying line if there is no word selected
  nnoremap <C-c> mjV"+y:redraw!<CR>`j
  inoremap <C-c> <C-\><C-o>mj<C-o>V"+y<C-o>:redraw!<CR><C-o>`j
  vnoremap <C-c> "+y:redraw!<CR>gv
  cnoremap <C-c> <C-y>

  " Ctrl X is cutting line if there is no word selected
  nnoremap <silent> <C-x>           :call SavePos()<CR>dd:call setpos(".", b:savepos)<CR>
  inoremap <silent> <C-x> <C-\><C-o>:call SavePos()<CR><C-\><C-o>dd<C-\><C-o>:call setpos(".", b:savepos)<CR><C-g>u
  vnoremap <silent> <C-x> "+x
  cnoremap <C-x> <C-y><C-e><C-u>

  " Shift-Insert same as Ctrl-v
  inoremap <S-Insert> <C-o>"+gP<C-g>u
  nnoremap <S-Insert> "+gPi<C-g>u
  vnoremap <S-Insert> "_d"+gP

  " Insert same as Ctrl-v
  inoremap <Insert> <C-o>"+gP<C-g>u
  nnoremap <Insert> "+gPi<C-g>u
  vnoremap <Insert> "_d"+gP
  " For Visual-Block Insert and command-line mode
  noremap! <Insert> <C-r>+

  " Delete selected characters before Entering the insert mode
  nnoremap <C-Del> "_dwi
  inoremap <C-Del> <C-o>"_dw<C-g>u
  vnoremap <C-BS> "_di

  " Alt - Backspace kill a word
  nnoremap <A-BS> "_dBi<C-g>u
  inoremap <A-BS> <C-w><C-g>u
  vnoremap <A-BS> "_d
  cnoremap <A-BS> <C-w>

  " Alt - Arrow, Move a word
  nnoremap <A-Right> w
  inoremap <A-Right> <C-Right>
  cnoremap <A-Right> <C-Right>
  vnoremap <A-Right> 5l
  nnoremap <A-Left> b
  inoremap <A-Left> <C-Left>
  cnoremap <A-Left> <C-Left>
  vnoremap <A-Left> 5h
else
  call SyntaxMonokai()
endif
