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
syntax enable " Enable syntax highlights
set ttyfast " Faster redraw
set lazyredraw " Lazy redraw
set shortmess+=I " No intro when starting Vim
set expandtab " Insert spaces instead of tabs
set softtabstop=4 " ... and insert four spaces
set shiftwidth=4 " Indent with four spaces
set incsearch " Search as typing
set hlsearch " Highlight search results
set cursorline " Highlight the cursor line
set virtualedit=onemore " Allow the cursor to move just past the end of the line
set history=300 " Keep 300 undo
set wildmenu " Better command-line completion
set scrolloff=999 " Always keep max lines after or before when scrolling
set sidescrolloff=999 " Always keep max lines after or before whens side scrolling
set autoindent " auto indent
set smartindent " smart indent
set cindent " c style indent
set noshowmode " Don't display the current mode
set gdefault " The substitute flag g is on
set hidden " Hide the buffer instead of closing when switching
set backspace=indent,eol,start " The normal behaviour of backspace
set showtabline=2 " Always show tabs
set laststatus=2 " Always show status bar
set whichwrap=<,>,[,] " Alow arrow keys move to previous/next line
set updatetime=750
set autoread " Auto reload content if it changed outside of vim
set ignorecase " case insensitive but case sensitive in command mode
let &showbreak="\u21aa " " Show a left arrow when wrapping text
set mousemodel=extend " Disable right click popup in Gvim
set encoding=utf-8
set fileencodings=utf-8,gbk,big5,utf-16le,utf-16be,default,latin1
set viminfo+=n$HOME/viminfo " .viminfo location
set synmaxcol=3000 " Don't try to highlight lines with over 3000 characters
set guioptions-=T " Don't show toolbar in Gvim
set guioptions+=b " Show bottom (horizontal) scrollbar in Gvim
set guitabtooltip=%{expand('%:p')} " Use full path in GUI tab tooltip
let g:netrw_list_hide='' " Show all hidden files when using file explorer
let g:netrw_hide=0 " Show all hidden files when using file explorer
let g:netrw_sizestyle="H" " Human-readable file size in file explorer
let g:netrw_liststyle=1 " Like 'ls -al' in file explorer
let g:netrw_timefmt="" " Don't display time in file explorer
" Highlight code area in markdown
let g:markdown_fenced_languages = ["c","cpp","java","javascript","ruby","python","vim","css","html","xml","yaml","sh","conf","zsh","debsources","resolv","sudoers"]
" Open all cmd args in new tabs
execute ":silent tab all"
" Open help in new tabs
cnoreabbrev help <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tab help' : 'help')<CR>
cnoreabbrev h <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tab help' : 'h')<CR>

""" Prevent lag when hitting ESC
set ttimeoutlen=0
set timeoutlen=1000
au InsertEnter * set timeout | set ignorecase
au InsertLeave * set notimeout

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
let myVimDir = ""
if has("gui_running") && has('win32') || has('win64')
  let myVimDir = expand("$TMP/$USERNAME/.vim")
else
  let myVimDir = expand("/tmp/$USER/.vim")
endif
let myBackupDir = myVimDir . '/backup'
let mySwapDir = myVimDir . '/swap'
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir,'p')
  endif
endfunction
call EnsureDirExists(myVimDir)
call EnsureDirExists(myBackupDir)
call EnsureDirExists(mySwapDir)
set backup
set backupskip=/tmp/*
set backupext=.bak
let &directory = mySwapDir
let &backupdir = myBackupDir
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
      execute has("gui_running") == 1 ? 'browse confirm saveas %:p:h' : 'call feedkeys("\<ESC>:w ")'
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
    execute has("gui_running") == 1 ? "browse confirm e %:p:h" : "Explore %:p:h"
  else
    execute has("gui_running") == 1 ? "browse confirm tabe %:p:h" : "Texplore %:p:h"
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
function! PasteFromClipboard()
  if line(".") == 1
    normal! O
    execute "r /tmp/$USER/clipboard.txt"
    execute "1d"
  else
    normal! k
    execute "r /tmp/$USER/clipboard.txt"
  endif
endfunction
" Usefull shortcuts to enter insert mode
nnoremap <CR> i<CR>
nnoremap <Backspace> i<Backspace>
nnoremap <Space> i<Space>
" Vim undo too much
inoremap <Space> <Space><C-g>u
inoremap <CR> <CR><C-g>u
inoremap <Tab> <Tab><C-g>u

" Backspace is deleting in visual mode
call CreateShortcut("BS", "di<C-g>u", "v")

" Ctrl A - Begin Line
call CreateShortcut("C-a", "0", "inv")

" Ctrl E - End Line
call CreateShortcut("C-e", "$l", "inv")

" Ctrl C - Copy
call CreateShortcut("C-c", "V:w! /tmp/$USER/clipboard.txt<CR>", "ni")
vnoremap <silent> <C-c> y:call delete(expand("/tmp/$USER/clipboard.txt"))<CR>:new /tmp/$USER/clipboard.txt<CR>P:w!<CR>:bdelete!<CR>

" Ctrl X - Cut
call CreateShortcut("C-x", "V:w! /tmp/$USER/clipboard.txt<CR>dd", "n")
call CreateShortcut("C-x", "V:w! /tmp/$USER/clipboard.txt<CR>ddi<C-g>u", "i", "noTrailingIInInsert")
vnoremap <silent> <C-x> ygvd<CR>:call delete(expand("/tmp/$USER/clipboard.txt"))<CR>:new /tmp/$USER/clipboard.txt<CR>P:w!<CR>:bdelete!<CR>

" Ctrl V - Paste
call CreateShortcut("C-v", ":call PasteFromClipboard()<CR>", "n")
call CreateShortcut("C-v", ":call PasteFromClipboard()<CR>i<C-g>u", "i", "noTrailingIInInsert")

" Ctrl S - Save
call CreateShortcut("C-s", ":call MySave()<CR>", "n")
inoremap <C-s> <C-g>u<C-\><C-O>:call MySave()<CR>
vnoremap <C-s> <ESC>:<C-u>call MySave()<CR>

" Home - Go To Begin
call CreateShortcut("Home", "gg", "inv")

" End - Go To End
call CreateShortcut("End", "G", "inv")

" Insert - Paste from system clipboard
call CreateShortcut("Insert", "<C-o>\"+gP<C-g>u", "i", "noLeadingESCInInsert", "noTrailingIInInsert")
call CreateShortcut("Insert", "\"+gP", "n")
call CreateShortcut("Insert", "d\"+gP", "v")
cnoremap <Insert> <C-r>+

" Ctrl K - Delete Line
call CreateShortcut("C-k", "dd", "n")
call CreateShortcut("C-k", "<C-o>dd<C-g>u", "i", "noLeadingESCInInsert", "noTrailingIInInsert")
vnoremap <C-k> <ESC>:execute line("'<").",".line("'>")."d"<CR>

" Ctrl D - Duplicate Line
call CreateShortcut("C-d", "mjyyp`jj", "n")
inoremap <C-d> <C-\><C-O>:normal! mjyyp`jj<CR><C-g>u
vnoremap <C-d> yPgv

" Ctrl Q - Visual block selection
call CreateShortcut("C-q", "<C-v>", "nv")
inoremap <C-q> <C-\><C-o><C-v>

" Ctrl Up - Pageup, &scroll = half of screen lines
call CreateShortcut("C-Up", &scroll*5/3."k", "nv")
inoremap <C-Up> <C-\><C-O>:execute "normal! ".&scroll*5/3."k"<CR>

" Ctrl Down - Pagedown
call CreateShortcut("C-Down",  &scroll*5/3."j", "nv")
inoremap <C-Down> <C-\><C-O>:execute "normal! ".&scroll*5/3."j"<CR>

" Ctrl U - Pageup
call CreateShortcut("C-u", &scroll*5/3."k", "nv")
inoremap <C-u> <C-\><C-O>:execute "normal! ".&scroll*5/3."k"<CR>

" Ctrl J - Pagedown
call CreateShortcut("C-j", &scroll*5/3."j", "nv")
inoremap <C-j> <C-\><C-O>:execute "normal! ".&scroll*5/3."j"<CR>

" Ctrl F - Find
call CreateShortcut("C-f", ":noh<CR>:set noignorecase<CR>/\\c", "in", "noTrailingIInInsert")
vnoremap <C-f> <Esc>:noh<CR>:set noignorecase<CR>/\%V\c

" Ctrl R - Search and Replace
call CreateShortcut("C-r", ":noh<CR>:set noignorecase<CR>:%s/", "in", "noTrailingIInInsert")
vnoremap <C-r> <Esc>:noh<CR>:set noignorecase<CR>:'<,'>s/\%V

" Ctrl G - Select all
call CreateShortcut("C-g", "ggVG", "inv")

" Ctrl L - Delete all lines
call CreateShortcut("C-l", "ggdG", "in")

" Pageup - Move up Line
nnoremap <silent> <PageUp> mj:<C-u>silent! move-2<CR>`j
inoremap <silent> <PageUp> <C-\><C-O>mj<C-O>:<C-u>silent! move-2<CR><C-O>`j<C-g>u
vnoremap <silent> <PageUp> :<C-u>silent! '<,'>move-2<CR>gv

" Pagedown - Move down Line
nnoremap <silent> <PageDown> mj:<C-u>silent! move+<CR>`j
inoremap <silent> <PageDown> <C-\><C-O>mj<C-O>:<C-u>silent! move+<CR><C-O>`j<C-g>u
vnoremap <silent> <PageDown> :<C-u>silent! '<,'>move'>+<CR>gv

" Ctrl W - Quit
call CreateShortcut("C-w", ":call MyQuit()<CR>", "inv")

" Tab - Indent
call CreateShortcut("Tab", ">>", "n")
call CreateShortcut("Tab", ">", "v", "restoreSelectionAfter")

" Shift Tab - UnIndent
call CreateShortcut("S-Tab", "<<", "in")
call CreateShortcut("S-Tab", "<", "v", "restoreSelectionAfter")

" Ctrl Z - Undo
call CreateShortcut("C-z", "u", "n")
call CreateShortcut("C-z", "<C-o>u", "i", "noLeadingESCInInsert", "noTrailingIInInsert")
vnoremap <C-z> <ESC>u
cnoremap <C-z> <ESC>u

" Ctrl Y - Redo
call CreateShortcut("C-y", "<C-r>", "n")
call CreateShortcut("C-y", "<C-o><C-r>", "i", "noLeadingESCInInsert", "noTrailingIInInsert")
cnoremap <C-y> <ESC><C-r>

" Ctrl T - New tab
call CreateShortcut("C-t", ":tabnew<CR>i", "inv", "noTrailingIInInsert", "cmdInVisual")

" Alt Right - Next tab
call CreateShortcut("A-Right", "gt", "inv")

" Alt Left - Previous tab
call CreateShortcut("A-Left", "gT", "inv")

" Ctrl N - Next word
call CreateShortcut("C-n", "w", "n")
inoremap <C-n> <C-\><C-o>w
vnoremap <C-n> 5l

" Terminal Alt Right - Next word
execute "set <M-C>=\e\eOC"
nnoremap <M-C> w
inoremap <M-C> <C-\><C-o>w
vnoremap <M-C> 5l

" Ctrl P - Previous word
call CreateShortcut("C-p", "b", "n")
inoremap <C-p> <C-\><C-o>b
vnoremap <C-p> 5h

" Terminal Alt Left - Previous word
execute "set <M-D>=\e\eOD"
nnoremap <M-D> b
inoremap <M-D> <C-\><C-o>b
vnoremap <M-D> 5h

" Ctrl Left - Previous 5 column
vnoremap <C-Left> 5h

" Ctrl Right - Next 5 column
vnoremap <C-Right> 5l

" Ctrl O - Netrw (:Explore)
call CreateShortcut("C-o",":call OpenNetrw()<CR>", "inv", "noTrailingIInInsert", "cmdInVisual")

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
  " Exit explorer without closing vim
  nmap <buffer> <silent> <C-w> :bd<CR>
endfunction

""" Custom commands

" :UndoCloseTab - To undo close tab
command! UndoCloseTab call OpenLastBufferInNewTab()

" :RemoveTrailingSpaces - To remove unwanted space(s) at the end of lines
command! RemoveTrailingSpaces %s/\s\+$

""" Colors and Statusline

let defaultAccentColor=161
let colorsAndModes= {
  \ 'i' : 39,
  \ 'v' : 82,
  \ 'V' : 226,
  \ '' : 208,
\}
let defaultAccentColorGui='#d7005f'
let colorsAndModesGui= {
  \ 'i' : '#00afff',
  \ 'v' : '#5fff00',
  \ 'V' : '#ffff00',
  \ '' : '#ff8700',
\}
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
function! ReadOnly()
  return (&readonly || !&modifiable) ? 'Read Only ' : ''
endfunction
function! Modified()
  return (&modified) ? 'Modified' : 'Not modified'
endfunction
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
    \ 'R'  : 'Replace',
    \ 'Rv' : 'VReplace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal',
\}
set statusline=
set statusline+=%{ChangeAccentColor()}
set statusline+=%1*\ ***%{toupper(g:currentmode[mode()])}***\  " Current mode
set statusline+=%2*\ %<%F\  " Filepath
set statusline+=%2*\ %= " To the right
set statusline+=%2*\ %{toupper((&fenc!=''?&fenc:&enc))}\[%{&ff}] " Encoding & Fileformat
set statusline+=%2*\ %{Modified()} " Modified Flags
set statusline+=%2*\ [%{&filetype}] " Filetype
set statusline+=%2*\ %{ReadOnly()} " ReadOnly Flags
set statusline+=%1*\ \%l/%L(%P)-%c\  " Position
" Speed up the redraw
au InsertLeave * call ChangeAccentColor()
au CursorHold * let &ro = &ro

"""" Color Scheme

"" Placed here for convenience.
"" Copied from tomasr Monokai on Github,
"" and slightly modified.

set background=dark
highlight clear
syntax reset
set t_Co=256

let g:is_bash=1 " Tell $VIMRUNTIME/syntax/sh.vim that I am using bash

" Normal is background color
hi Normal ctermfg=231 ctermbg=235 cterm=NONE guifg=#F8F8F2 guibg=#1B1D1E gui=NONE
" Visual is selected color
hi Visual ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00afff gui=NONE
" Pmenu is popup autocomplete color
hi Pmenu ctermfg=39 ctermbg=255 cterm=NONE guifg=#00afff guibg=White
hi PmenuSel ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00afff

hi Green ctermfg=34 ctermbg=NONE cterm=NONE guifg=#00af00 guibg=NONE gui=NONE
hi iGreen ctermfg=0 ctermbg=34 cterm=NONE guifg=#000000 guibg=#00af00 gui=NONE
hi PreProc ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Search ctermfg=226 ctermbg=NONE cterm=NONE guibg=yellow guifg=black

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
hi Normal               ctermfg=252     ctermbg=233     guifg=#F8F8F2     guibg=#1B1D1E
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

" Final redraw
call ChangeAccentColor()

autocmd FileType text call HighlightTXT()
autocmd BufRead,BufNewFile,BufWritePost *.{srt,SRT} call HighlightSRT()
autocmd BufRead,BufNewFile,BufWritePost *.{vtt,VTT} call HighlightVTT()
autocmd BufRead,BufNewFile,BufWritePost *.{ass,ASS,ssa,SSA} call HighlightASS()

function! HighlightTXT()
  " Copy from $VIM/syntax/lua.vim
  " integer number
  syn match txtNumber "\<\d\+\>"
  " floating point number, with dot, optional exponent
  syn match txtNumber  "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
  " floating point number, starting with a dot, optional exponent
  syn match txtNumber  "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
  " floating point number, without dot, with exponent
  syn match txtNumber  "\<\d\+[eE][-+]\=\d\+\>"
  syn match lineURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
  hi def link txtNumber	  Number
  hi def link lineURL	    Define
endfunction

function! HighlightSRT()
  setlocal filetype=srt
  syn case ignore
  syn match srtContent ".*"
  syn match srtArrow " --> "
  syn match srtComment "^#.*"
  syn match srtError "\[br\]"
  syn match srtError "{y:[bi][bi]}"
  syn match srtError "{y:[bi]}"
  syn match srtNumber "^[0-9]*$"
  syn region transparent matchgroup=srtTime start='[0-9]*:[0-9]*:[0-9]*,[0-9]*' end='[0-9]*:[0-9]*:[0-9]*,[0-9]*' contains=srtArrow

  hi def link srtArrow      Type
  hi def link srtComment    Comment
  hi def link srtContent    Identifier
  hi def link srtError      Error
  hi def link srtNumber     Number
  hi def link srtTime       Statement
endfunction

function! HighlightVTT()
  setlocal filetype=webvtt
  syn case ignore
  syn match vttContent ".*"
  syn match vttArrow " --> "
  syn match vttComment "^#.*"
  syn match vttError "\[br\]"
  syn match vttError "{y:[bi][bi]}"
  syn match vttError "{y:[bi]}"
  syn match vttNumber "^[0-9]*$"
  syn region transparent matchgroup=vttTime start='[0-9:]\+\.[0-9]*' end='[0-9:]\+\.[0-9]*' contains=vttArrow

  hi def link vttArrow      Type
  hi def link vttComment    Comment
  hi def link vttContent    Identifier
  hi def link vttError      Error
  hi def link vttNumber     Number
  hi def link vttTime       Statement
endfunction

function! HighlightASS()
  setlocal filetype=ssa
  syn match ssaSection       "^\[.*\]"
  syn match ssaSourceComment "^;.*$"
  syn match ssaLine          "^[^;][^:]*:.*$"  contains=ssaHeader,ssaComment,ssaDialog
  syn match ssaHeader        "^[^;][^:]*:\s*"  contained nextgroup=ssaHeaderText
  syn match ssaHeaderText    ".*$"             contained
  syn match ssaComment       "^Comment:\s*"    contained nextgroup=ssaCommentText
  syn match ssaCommentText   ".*$"             contained
  syn match ssaDialog        "^Dialogue:\s*"   contained nextgroup=ssaDialogTimes
  syn match ssaDialogTimes   "\([^,]*,\)\{4}"  contained nextgroup=ssaDialogActor
  syn match ssaDialogActor   "[^,]*"           contained nextgroup=ssaDialogEffects
  syn match ssaDialogEffects ",\([^,]*,\)\{4}" contained nextgroup=ssaDialogText
  syn match ssaDialogText    ".*$"             contained contains=ssaTextComment,ssaTextSubCode
  syn match ssaTextComment   "{[^}]*}"         contained
  syn match ssaTextSubCode   "{\\[^}]*}"       contained

  hi def link ssaSection         Function
  hi def link ssaSourceComment   Comment
  hi def link ssaHeader          Statement
  hi def link ssaComment         Statement
  hi def link ssaDialog          Statement
  hi def link ssaHeaderText      Constant
  hi def link ssaCommentText     Comment
  hi def link ssaDialogTimes     Type
  hi def link ssaDialogActor     Title
  hi def link ssaDialogEffects   Function
  hi def link ssaDialogText      Identifier
  hi def link ssaTextComment     Comment
  hi def link ssaTextSubCode     Comment
endfunction

autocmd Filetype * setlocal omnifunc=syntaxcomplete#Complete
set completeopt=menuone,noinsert,noselect,longest
set complete=.
set shortmess+=c

let autocomp=0
inoremap <silent> <F10> <C-\><C-O>:call ToggleAutoComplete()<CR>
vnoremap <silent> <F10> <ESC>:call ToggleAutoComplete()<CR>
nnoremap <silent> <F10>      :call ToggleAutoComplete()<CR>

let g:CharSet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function! ToggleAutoComplete()
  if (g:autocomp == 0)
    let g:autocomp=1
    for l:char in split(g:CharSet, '\zs')
      execute "inoremap <silent> ".l:char." ".l:char."<ESC>a<C-r>=SmartComplete()<CR>"
    endfor
  else
    let g:autocomp=0
    for l:char in split(g:CharSet, '\zs')
      execute "inoremap <silent> ".l:char." ".l:char
    endfor
  endif
endfunction

function! SmartComplete()
  if (col(".") == 1 || col(".") == 2) " empty lines, omni matching
    return "\<C-x>\<C-o>"
  endif

  let currentChar = matchstr(getline('.'), '\%' . (col('.')-2) . 'c.')

  if match(g:CharSet, currentChar) == -1 " First character, omni matching
    return "\<C-x>\<C-o>"
  endif

  return "\<C-x>\<C-p>" " Currnt file matching
endfunction

set noerrorbells " disable error sound
autocmd VimEnter * set noerrorbells " disable error sound
set vb t_vb= " disable visual bell
set t_vb= " disable visual bell
autocmd VimEnter * set vb t_vb= " disable visual bell
set smartcase& " No smart
set nowrap " Don't wrap text
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
" set iskeyword-=_ " _ Should not be one of the keywords

if has("gui_running")
  if has('win32') || has('win64')
    set backup
    set backupskip=$TEMP
    set undodir=$TEMP
    set directory=$TEMP
    set backupdir=$TEMP
    set guifont=Ubuntu\ Mono:h14
    set guifontwide=DroidMono:h13
    au GUIEnter * simalt ~x " Full screen on start
  else
    set guifont=Ubuntu\ Mono\ 14
  endif
  set number
  set lines=999 columns=999 " set window Maximized
  set guicursor=a:ver25-Cursor/lCursor-blinkon0 " disable cursor flashing
  set selection=exclusive " Don't select char under cursor
  set mouseshape+=a:beam " set cursor shape as modern editors should be
  set scrolloff& " unset scroll values
  set sidescrolloff&
  set clipboard& " unset clipboard

  " Ctrl C is copying line if there is no word selected
  call CreateShortcut("C-c", "V\"+y", "in")
  call CreateShortcut("C-c", "\"+y", "v")
  cnoremap <C-c> <C-y>

  " Ctrl X is cutting line if there is no word selected
  call CreateShortcut("C-x", "<C-o>V\"+x<C-g>u", "i", "noLeadingESCInInsert", "noTrailingIInInsert")
  call CreateShortcut("C-x", "V\"+x", "n")
  call CreateShortcut("C-x", "\"+x", "v")
  cnoremap <C-x> <C-y><C-e><C-u>

  " Ctrl v is paste / override selected then paste
  call CreateShortcut("C-v", "<C-o>\"+gP<C-g>u", "i", "noLeadingESCInInsert", "noTrailingIInInsert")
  call CreateShortcut("C-v", "\"+gP", "n")
  call CreateShortcut("C-v", "d\"+gP", "v")
  cnoremap <C-v> <C-r>+

  " Shift-Insert same as Ctrl-v
  call CreateShortcut("S-Insert", "<C-o>\"+gP<C-g>u", "i", "noLeadingESCInInsert", "noTrailingIInInsert")
  call CreateShortcut("S-Insert", "\"+gP", "n")
  call CreateShortcut("S-Insert", "d\"+gP", "v")
  cnoremap <S-Insert> <C-r>+

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

  " Deleting words and Entering insert mode
  call CreateShortcut("CR", "di<CR><C-g>u", "v")
  call CreateShortcut("Space", "di<Space><C-g>u", "v")
  call CreateShortcut("C-BS", "di<C-g>u", "v")
  call CreateShortcut("C-Del", "ldwi<C-g>u", "i", "noTrailingIInInsert")
  nnoremap <C-Del> dwi

  " Get into insert mode by pressing any key in visual mode
  for b:char in split(g:CharSet, '\zs')
    execute "vnoremap ".b:char." di<C-g>u".b:char
  endfor
endif

inoremap {<CR> {<CR>}<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap (<CR> (<CR>)<ESC>O
vnoremap ( <ESC>:call WrapSelected("(",")")<CR>
vnoremap [ <ESC>:call WrapSelected("[","]")<CR>
vnoremap { <ESC>:call WrapSelected("{","}")<CR>
vnoremap ) <ESC>:call WrapSelected("(",")")<CR>
vnoremap ] <ESC>:call WrapSelected("[","]")<CR>
vnoremap } <ESC>:call WrapSelected("{","}")<CR>
vnoremap ' <ESC>:call WrapSelected("'","'")<CR>
vnoremap " <ESC>:call WrapSelected("\"","\"")<CR>
vnoremap < <ESC>:call WrapSelected("<",">")<CR>
vnoremap > <ESC>:call WrapSelected("<",">")<CR>

function! WrapSelected(c1, c2)
  execute "normal! `<i".a:c1
  execute "normal! `>a".a:c2
  execute "normal! l"
endfunction

" Byobu key binding
call CreateShortcut("F2", ":tabnew<CR>", "inv")
call CreateShortcut("C-t", ":tabnew<CR>", "inv")
call CreateShortcut("F3", ":tabp<CR>", "inv")
call CreateShortcut("F4", ":tabn<CR>", "inv")

" Ctrl \ is toggling comments
call CreateShortcut("C-\\", ":call ToggleComments()<CR>", "inv")

inoremap <C-b> <C-w>
nnoremap <C-b> i<C-w>
cnoremap <C-b> <C-w>
nnoremap <Del> i<Del>

" Useful command mode mapping
cnoremap <C-w> <C-c>
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
inoremap <C-BS> <C-W><C-g>u
nnoremap <C-BS> i<C-W><C-g>u
cnoremap <C-BS> <C-w>
inoremap <C-_> <C-W><C-g>u
nnoremap <C-_> i<C-W><C-g>u
cnoremap <C-_> <C-w>
vnoremap <bar> I

function! ForceFoldmethodIndent()
  if &foldenable
    set foldmethod=indent
  endif
endfunction

" minus key is folding/unfolding code in normal mode
nnoremap <silent> - :normal! zi<CR>:call ForceFoldmethodIndent()<CR>

" Commenting blocks of code.
autocmd FileType c,cpp,java         let b:comment_leader = '\/\/'
autocmd FileType javascript         let b:comment_leader = '\/\/'
autocmd FileType arduino            let b:comment_leader = '\/\/'
autocmd FileType registry           let b:comment_leader = ';'
autocmd FileType dosbatch           let b:comment_leader = '::'
autocmd FileType sh,ruby,python     let b:comment_leader = '#'
autocmd FileType conf,fstab,zsh     let b:comment_leader = '#'
autocmd FileType make,Cmake,yaml    let b:comment_leader = '#'
autocmd FileType debsources,desktop let b:comment_leader = '#'
autocmd FileType matlab,tex         let b:comment_leader = '%'
autocmd FileType vim                let b:comment_leader = '"'
autocmd FileType css                let b:comment_leader = '\/\*'   |   let b:comment_ender = '\*\/'
autocmd FileType html,xml,markdown  let b:comment_leader = '<!--'   |   let b:comment_ender = '-->'

function! ToggleComments()
  if exists('b:comment_leader')
    if getline(".") =~ '^' .b:comment_leader
      " uncomment the line
      execute 'silent s/^' .b:comment_leader.' //g'
      if exists('b:comment_ender')
        execute 'silent s/ ' .b:comment_ender.'$//g'
      endif
    elseif getline(".") =~ '^\s*$'
      " empty lines, ignore
    else
      " comment the line
      execute 'silent s/^/' .b:comment_leader.' /g'
      if exists('b:comment_ender')
        execute 'silent s/$/\ ' .b:comment_ender.'/g'
      endif
    endif
  else
    echo 'No comment leader found for filetype'
  endif
endfunction

" Indent by filetype
au FileType vim,conf,sh,zsh setlocal ts=2 sw=2 sts=2 " 2 spaces indent for vim files

function! JsonBeautify()
  execute "%!python -m json.tool"
endfunction

function! JsonMinify()
  set filetype=json
  filetype indent on
  execute "%s/\\s\\+$//e"
  execute "%left"
  execute "%j!"
endfunction

" Json pretty by python
nnoremenu Edit.Json.Beautify  :call JsonBeautify()<CR>
nnoremenu Edit.Json.Minify    :call JsonMinify()<CR>
command! JsonBeautify    execute "call JsonBeautify()"
command! JsonMinify      execute "call JsonMinify()"

" XML pretty by vim
function! XmlBeautify()
  call XmlMinify()
  execute "%s/></>\\r</e"
  normal! gg=G
endfunction

function! XmlMinify()
  set filetype=xml
  filetype indent on
  execute "%s/>\\s\\+</></e"
  execute "%s/\\s\\+$//e"
  execute "%left"
  execute "%j!"
endfunction

nnoremenu Edit.XML.Beautify   :call XmlBeautify()<CR>
nnoremenu Edit.XML.Minify     :call XmlMinify()<CR>
command! XmlBeautify    execute "call XmlBeautify()"
command! XmlMinify      execute "call XmlMinify()"

" Merge selected to one line
nnoremenu Edit.Merge\ to\ one\ line  :%left<CR>:%j!<CR>
vnoremenu Edit.Merge\ to\ one\ line  :%left<CR>gv:%j!<CR>

" Remove something
nnoremenu Edit.Remove.Empty\ lines          :g/^$/d<CR>
nnoremenu Edit.Remove.Leading\ whitespace   :%s/^\s\+//e<CR>
nnoremenu Edit.Remove.Trailing\ whitespace  :%s/\s\+$//e<CR>

command! RemoveLeadingSpace %s/^\s\+//e
command! RemoveEmptyLines   g/^$/d

" Fast rendering for current file
function! FastRender()
  setlocal nocursorline
  syntax clear
endfunction

noremenu Edit.FastRender :call FastRender()<CR>
command! FastRender execute "call FastRender()"

" Split view
noremenu Edit.Split\ Window.Vertical\ 2     :vsplit<CR>
noremenu Edit.Split\ Window.Vertical\ 3     :vsplit<CR>:vsplit<CR>:wincmd =<CR>
noremenu Edit.Split\ Window.Horizontal\ 2   :split<CR>
noremenu Edit.Split\ Window.Horizontal\ 3   :split<CR>:split<CR>:wincmd =<CR>

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
