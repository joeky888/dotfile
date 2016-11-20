""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MiniVim
" Details on : https://github.com/sd65/MiniVim
let g:UseCustomKeyBindings = get(g:, 'UseCustomKeyBindings', "1")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" General options
syntax enable " Enable syntax highlights
set ttyfast " Faster refraw
set shortmess+=I " No intro when starting Vim
set expandtab " Insert spaces instead of tabs
set softtabstop=4 " ... and insert four spaces
set shiftwidth=4 " Indent with four spaces
set incsearch " Search as typing
set hlsearch " Highlight search results
set cursorline " Highligt the cursor line
set showmatch " When a bracket is inserted, briefly jump to the matching one
set matchtime=1 " ... during this time
set virtualedit=onemore " Allow the cursor to move just past the end of the line
set history=100 " Keep 100 undo
set wildmenu " Better command-line completion
set scrolloff=10 " Always keep 10 lines after or before when scrolling
set sidescrolloff=5 " Always keep 5 lines after or before when side scrolling
set noshowmode " Don't display the current mode
set gdefault " The substitute flag g is on
set hidden " Hide the buffer instead of closing when switching
set backspace=indent,eol,start " The normal behaviour of backspace
set showtabline=2 " Always show tabs
set laststatus=2 " Always show status bar
set updatetime=750
" set smartcase " ... but smart
set ignorecase " case insensitive but case sensitive in command mode
let &showbreak="\u21aa " " Show a left arrow when wrapping text
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,big5,shift-jis,cp950,cp936,utf-16le,default,latin1
set synmaxcol=2000 " Don't try to highlight long lines
set guioptions-=T " Don't show toolbar in Gvim
" set iskeyword+=\- " Complete words containing a dash
" Open all cmd args in new tabs
execute ":silent tab all"

""" Prevent lag when hitting ESC
set ttimeoutlen=0
set timeoutlen=200
au InsertEnter * set timeout
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
let myVimDir = expand("$HOME/.vim")
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

""" Smart Paste
let &t_ti .= "\<ESC>[?2004h"
let &t_te .= "\<ESC>[?2004l"
function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction
execute "set <f28>=\<ESC>[200~"
execute "set <f29>=\<ESC>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>

""" Key mappings
if g:UseCustomKeyBindings

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
      if has("gui_running")
        call feedkeys("\<ESC>:browse confirm saveas\<CR>")
      else
        call feedkeys("\<ESC>:w ")
      endif
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
function! ToggleColorColumn()
    if &colorcolumn != 0
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn = 80
    endif
endfunction
function! MyPasteToggle()
  set invpaste
  echo "Paste" (&paste) ? "On" : "Off"
endfunction
function! OpenNetrw()
  if TabIsEmpty() == 1
    Explore
  else
    Texplore
  endif
endfunction
function! MenuNetrw()
  let c = input("What to you want to do? (M)ake a dir, Make a (F)ile, (R)ename, (D)elete : ")
  if (c == "m" || c == "M")
    normal d
  elseif (c == "f" || c == "F")
    normal %
  elseif (c == "r" || c == "R")
    normal R
  elseif (c == "d" || c == "D")
    normal D
  endif
endfunction

" Usefull shortcuts to enter insert mode
nnoremap <CR> i<CR>
nnoremap <Backspace> i<Backspace>
nnoremap <Space> i<Space>

" Ctrl A - Begin Line
call CreateShortcut("C-a", "0", "inv")

" Ctrl E - End Line
call CreateShortcut("C-e", "$l", "inv")

" Ctrl S - Save
call CreateShortcut("C-s", ":call MySave()<CR>", "nv", "cmdInVisual", "restoreSelectionAfter")
call CreateShortcut("C-s", ":call MySave()<CR>a", "i", "noTrailingIInInsert")

" Home - Go To Begin
call CreateShortcut("Home", "gg", "inv")

" End - Go To End
call CreateShortcut("End", "G", "inv")

" Ctrl K - Delete Line
call CreateShortcut("C-k", "dd", "in")
call CreateShortcut("C-k", "d", "v")

" Ctrl Q - Duplicate Line
call CreateShortcut("C-q", "mjyyp`jjl", "i")
call CreateShortcut("C-q", "mjyyp`jj", "n")
call CreateShortcut("C-q", "y`]p", "v")

" Ctrl Down - Pagedown
call CreateShortcut("C-Down", "15j", "inv")

" Ctrl Up - Pageup
call CreateShortcut("C-Up", "15k", "inv")

" Ctrl Right - Next Word
call CreateShortcut("C-Right", "w", "nv")

" Ctrl Left - Previous Word
call CreateShortcut("C-Left", "b", "nv")

" Ctrl F - Find
call CreateShortcut("C-f", ":noh<CR>:set noignorecase<CR>/\\c", "in", "noTrailingIInInsert")

" Ctrl R - Search and Replace
call CreateShortcut("C-r", ":noh<CR>:set noignorecase<CR>:%s/\\c", "in", "noTrailingIInInsert")

" Ctrl G - Search and Replace on the line only
call CreateShortcut("C-g", ":s/", "in", "noTrailingIInInsert")

" Ctrl L - Delete all lines
call CreateShortcut("C-l", "ggdG", "in")

" Pageup - Move up Line
call CreateShortcut("PageUp", ":m-2<CR>", "in")
call CreateShortcut("PageUp", "dkP", "v")

" Pagedown - Move down Line
call CreateShortcut("PageDown", ":m+<CR>", "in")
call CreateShortcut("PageDown", "dp", "v")

" Ctrl W - Quit
call CreateShortcut("C-w", ":call MyQuit()<CR>", "inv")

" Tab - Indent
call CreateShortcut("Tab", ">>", "n")
call CreateShortcut("Tab", ">", "v", "restoreSelectionAfter")

" Shift Tab - UnIndent
call CreateShortcut("S-Tab", "<<", "in")
call CreateShortcut("S-Tab", "<", "v", "restoreSelectionAfter")

" Ctrl Z - Undo
call CreateShortcut("C-z", "u", "ni")

" Ctrl R - Redo
call CreateShortcut("C-y", "<C-r>", "in")

" Ctrl D - Suppr (the key)
call CreateShortcut("C-d", "<del>", "iv", "noLeadingESCInInsert", "noTrailingIInInsert")
call CreateShortcut("C-d", "x", "n")

" Ctrl T - New tab
call CreateShortcut("C-t", ":tabnew<CR>i", "inv", "noTrailingIInInsert", "cmdInVisual")

" Alt Right - Next tab
call CreateShortcut("A-Right", "gt", "inv")

" Alt Left - Previous tab
call CreateShortcut("A-Left", "gT", "inv")

" F2 - Paste toggle
call CreateShortcut("f2",":call MyPasteToggle()<CR>", "n")

" F3 - Line numbers toggle
call CreateShortcut("f3",":set nonumber!<CR>", "in")

" F4 - Panic Button
call CreateShortcut("f4","mzggg?G`z", "inv")

" F6 - Toggle color column at 80th char
call CreateShortcut("f6",":call ToggleColorColumn()<CR>", "inv")

" Ctrl O - Netrw (:Explore)
if has("gui_running")
    call CreateShortcut("C-o",":browse confirm e<CR>", "inv")
else
    call CreateShortcut("C-o",":call OpenNetrw()<CR>", "inv", "noTrailingIInInsert", "cmdInVisual")
endif
let g:netrw_banner=0 " Hide banner
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' " Hide hidden files
autocmd FileType netrw call KeysInNetrw()
function! KeysInNetrw()
  " Right to enter
  nmap <buffer> <Right> <CR>
  " Left to go up
  nmap <buffer> <Left> -
  " l - Display info
  nmap <buffer> l qf
  " n - Menu
  nmap <buffer> n :call MenuNetrw()<CR>
endfunction

endif " End custom key bindings

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
  execute 'hi User3 ctermfg=0 guifg=#000000 cterm=bold gui=bold ctermbg=' . accentColor . ' guibg=' . accentColorGui
  execute 'hi TabLineSel ctermfg=0 cterm=bold ctermbg=' . accentColor
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
set statusline+=%2*\ %{Modified()}\ %{ReadOnly()} " Flags
set statusline+=%2*\ [%{&filetype}]\  " Filetype
set statusline+=%1*\ \%l/%L(%P)-%c\  " Position
" Speed up the redraw
au InsertLeave * call ChangeAccentColor()
au CursorHold * let &ro = &ro

"""" Color Scheme

"" Placed here for convenience.
"" Copied from sickill Monokai on Github,
"" and slightly modified.

set background=dark
highlight clear
syntax reset
set t_Co=256
hi Green ctermfg=34 ctermbg=NONE cterm=NONE guifg=#00af00 guibg=NONE gui=NONE
hi iGreen ctermfg=0 ctermbg=34 cterm=NONE guifg=#000000 guibg=#00af00 gui=NONE
hi Cursor ctermfg=235 ctermbg=231 cterm=NONE guifg=#272822 guibg=#f8f8f0 gui=NONE
hi Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#49483e gui=NONE
hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE
hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE
hi MatchParen ctermfg=197 ctermbg=NONE cterm=underline guifg=#f92672 guibg=NONE gui=underline
hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#f8f8f2 guibg=#64645e gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#49483e gui=NONE
hi IncSearch ctermfg=235 ctermbg=186 cterm=NONE guifg=#272822 guibg=#e6db74 gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=161 ctermbg=NONE cterm=NONE guifg=#d7005f guibg=NONE gui=NONE
hi Folded ctermfg=242 ctermbg=235 cterm=NONE guifg=#75715e guibg=#272822 gui=NONE
hi SignColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi Normal ctermfg=231 ctermbg=235 cterm=NONE guifg=#f8f8f2 guibg=#272822 gui=NONE
hi Boolean ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Character ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Comment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE
hi Conditional ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi DiffAdd ctermfg=231 ctermbg=64 cterm=bold guifg=#f8f8f2 guibg=#46830c gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8b0807 guibg=NONE gui=NONE
hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=#243955 gui=NONE
hi DiffText ctermfg=231 ctermbg=24 cterm=bold guifg=#f8f8f2 guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi WarningMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi Float ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Function ctermfg=148 ctermbg=NONE cterm=NONE guifg=#a6e22e guibg=NONE gui=NONE
hi Identifier ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi Keyword ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Label ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi NonText ctermfg=59 ctermbg=236 cterm=NONE guifg=#49483e guibg=#31322c gui=NONE
hi Number ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Operator ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi PreProc ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Special ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=NONE gui=NONE
hi SpecialComment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE
hi SpecialKey ctermfg=59 ctermbg=237 cterm=NONE guifg=#49483e guibg=#3c3d37 gui=NONE
hi Statement ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi StorageClass ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi String ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi Tag ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#f8f8f2 guibg=NONE gui=bold
hi Todo ctermfg=95 ctermbg=NONE cterm=inverse,bold guifg=#75715e guibg=NONE gui=inverse,bold
hi Type ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi rubyFunction ctermfg=148 ctermbg=NONE cterm=NONE guifg=#a6e22e guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi rubyConstant ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=208 ctermbg=NONE cterm=NONE guifg=#fd971f guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInclude ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi rubyEscape ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi rubyControl ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi rubyException ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=95 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAlias ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi cssURL ctermfg=208 ctermbg=NONE cterm=NONE guifg=#fd971f guibg=NONE gui=NONE
hi cssFunctionName ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi cssColor ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=148 ctermbg=NONE cterm=NONE guifg=#a6e22e guibg=NONE gui=NONE
hi cssClassName ctermfg=148 ctermbg=NONE cterm=NONE guifg=#a6e22e guibg=NONE gui=NONE
hi cssValueLength ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi TabLineFill cterm=bold ctermbg=0
" Final redraw
call ChangeAccentColor()

set completeopt=menuone,noinsert,noselect,longest
set complete-=w,b,u,t,i
set shortmess+=c

let autocomp=0
inoremap <silent> <F10> <ESC>:call ToggleAutoComplete()<CR>a
vnoremap <silent> <F10> <ESC>:call ToggleAutoComplete()<CR>
nnoremap <silent> <F10>      :call ToggleAutoComplete()<CR>

function! ToggleAutoComplete()
  if (g:autocomp == 0)
    let g:autocomp=1
    inoremap <silent> a a<ESC>a<C-x><C-p>
    inoremap <silent> b b<ESC>a<C-x><C-p>
    inoremap <silent> c c<ESC>a<C-x><C-p>
    inoremap <silent> d d<ESC>a<C-x><C-p>
    inoremap <silent> e e<ESC>a<C-x><C-p>
    inoremap <silent> f f<ESC>a<C-x><C-p>
    inoremap <silent> g g<ESC>a<C-x><C-p>
    inoremap <silent> h h<ESC>a<C-x><C-p>
    inoremap <silent> i i<ESC>a<C-x><C-p>
    inoremap <silent> j j<ESC>a<C-x><C-p>
    inoremap <silent> k k<ESC>a<C-x><C-p>
    inoremap <silent> l l<ESC>a<C-x><C-p>
    inoremap <silent> m m<ESC>a<C-x><C-p>
    inoremap <silent> n n<ESC>a<C-x><C-p>
    inoremap <silent> o o<ESC>a<C-x><C-p>
    inoremap <silent> p p<ESC>a<C-x><C-p>
    inoremap <silent> q q<ESC>a<C-x><C-p>
    inoremap <silent> r r<ESC>a<C-x><C-p>
    inoremap <silent> s s<ESC>a<C-x><C-p>
    inoremap <silent> t t<ESC>a<C-x><C-p>
    inoremap <silent> u u<ESC>a<C-x><C-p>
    inoremap <silent> v v<ESC>a<C-x><C-p>
    inoremap <silent> w w<ESC>a<C-x><C-p>
    inoremap <silent> x x<ESC>a<C-x><C-p>
    inoremap <silent> y y<ESC>a<C-x><C-p>
    inoremap <silent> z z<ESC>a<C-x><C-p>
    inoremap <silent> A A<ESC>a<C-x><C-p>
    inoremap <silent> B B<ESC>a<C-x><C-p>
    inoremap <silent> C C<ESC>a<C-x><C-p>
    inoremap <silent> D D<ESC>a<C-x><C-p>
    inoremap <silent> E E<ESC>a<C-x><C-p>
    inoremap <silent> F F<ESC>a<C-x><C-p>
    inoremap <silent> G G<ESC>a<C-x><C-p>
    inoremap <silent> H H<ESC>a<C-x><C-p>
    inoremap <silent> I I<ESC>a<C-x><C-p>
    inoremap <silent> J J<ESC>a<C-x><C-p>
    inoremap <silent> K K<ESC>a<C-x><C-p>
    inoremap <silent> L L<ESC>a<C-x><C-p>
    inoremap <silent> M M<ESC>a<C-x><C-p>
    inoremap <silent> N N<ESC>a<C-x><C-p>
    inoremap <silent> O O<ESC>a<C-x><C-p>
    inoremap <silent> P P<ESC>a<C-x><C-p>
    inoremap <silent> Q Q<ESC>a<C-x><C-p>
    inoremap <silent> R R<ESC>a<C-x><C-p>
    inoremap <silent> S S<ESC>a<C-x><C-p>
    inoremap <silent> T T<ESC>a<C-x><C-p>
    inoremap <silent> U U<ESC>a<C-x><C-p>
    inoremap <silent> V V<ESC>a<C-x><C-p>
    inoremap <silent> W W<ESC>a<C-x><C-p>
    inoremap <silent> X X<ESC>a<C-x><C-p>
    inoremap <silent> Y Y<ESC>a<C-x><C-p>
    inoremap <silent> Z Z<ESC>a<C-x><C-p>
  else
    let g:autocomp=0
    inoremap <silent> a a
    inoremap <silent> b b
    inoremap <silent> c c
    inoremap <silent> d d
    inoremap <silent> e e
    inoremap <silent> f f
    inoremap <silent> g g
    inoremap <silent> h h
    inoremap <silent> i i
    inoremap <silent> j j
    inoremap <silent> k k
    inoremap <silent> l l
    inoremap <silent> m m
    inoremap <silent> n n
    inoremap <silent> o o
    inoremap <silent> p p
    inoremap <silent> q q
    inoremap <silent> r r
    inoremap <silent> s s
    inoremap <silent> t t
    inoremap <silent> u u
    inoremap <silent> v v
    inoremap <silent> w w
    inoremap <silent> x x
    inoremap <silent> y y
    inoremap <silent> z z
    inoremap <silent> A A
    inoremap <silent> B B
    inoremap <silent> C C
    inoremap <silent> D D
    inoremap <silent> E E
    inoremap <silent> F F
    inoremap <silent> G G
    inoremap <silent> H H
    inoremap <silent> I I
    inoremap <silent> J J
    inoremap <silent> K K
    inoremap <silent> L L
    inoremap <silent> M M
    inoremap <silent> N N
    inoremap <silent> O O
    inoremap <silent> P P
    inoremap <silent> Q Q
    inoremap <silent> R R
    inoremap <silent> S S
    inoremap <silent> T T
    inoremap <silent> U U
    inoremap <silent> V V
    inoremap <silent> W W
    inoremap <silent> X X
    inoremap <silent> Y Y
    inoremap <silent> Z Z
  endif
endfunction

set noerrorbells "disable error sound
set vb t_vb= "disable visualbell
" set ignorecase " Search insensitive
set smartcase& " No smart
set nowrap
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
set iskeyword& " '-' should not be one of the keywords
" set backspace=2

if has("gui_running")
    if has('gui_win32')
        set backup
        set backupskip=%TMP%
        set undodir=%TMP%
        set directory=%TMP%
        set backupdir=%TMP%
        set guifont=Ubuntu\ Mono:h14
        set guifontwide=DroidMono:h13
    else
        set guifont=Ubuntu\ Mono\ 14
    endif
    set number
    set autoindent " auto indent
    set lines=999 columns=999 " set window Maximized
    set guicursor=n-v-c-ci-i:ver25-Cursor/lCursor
    set selection=exclusive " Don't select char under cursor
    set mouseshape+=v:beam,n:beam " set cursor shape as modern editors should be
    set guicursor=a:blinkon0 " disable cursor flashing
    set scrolloff& " unset scroll values
    set sidescrolloff&

    " Ctrl C is copying line if there is no word seleted
    call CreateShortcut("C-c", "<S-v>\"+y", "in")
    call CreateShortcut("C-c", "\"+y", "v")
    cnoremap <C-c> <C-y>

    " Ctrl X is cutting line if there is no word seleted
    call CreateShortcut("C-x", "<S-v>\"+x", "in")
    call CreateShortcut("C-x", "\"+x", "v")
    cnoremap <C-x> <C-y><C-e><C-u>

    " Ctrl v is paste / override selected then paste
    call CreateShortcut("C-v", ":call paste#Paste()<CR>", "i")
    call CreateShortcut("C-v", "\"+gP", "n")
    call CreateShortcut("C-v", "dh\"+p<Right>", "v")
    cnoremap <C-v> <C-r>+

    " Useful command mode mapping
    cnoremap <C-w> <C-c>
    cnoremap <C-k> <C-e><C-u>
    cnoremap <C-f> <C-e><C-u>\c
    cnoremap <C-r> <C-e><C-u>noh<CR>:%s/\c
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>

    " Ctrl d is copying line
    call CreateShortcut("C-d", "yyp", "in")

    " Ctrl g is selecting all
    call CreateShortcut("C-g", "ggVG", "inv")

    " Byobu key binding
    call CreateShortcut("F2", ":tabnew<CR>", "inv")
    call CreateShortcut("C-t", ":tabnew<CR>", "inv")
    call CreateShortcut("F3", ":tabp<CR>", "inv")
    call CreateShortcut("F4", ":tabn<CR>", "inv")

    " Ctrl \ is toggling comments
    call CreateShortcut("C-\\", ":call ToggleComment()<CR>", "in")
    vnoremap <silent> <C-\> <ESC>:call ToggleComments()<CR>

    " Meta LeftMouse is block selecting
    noremap  <M-LeftMouse> <4-LeftMouse>
    inoremap <M-LeftMouse> <4-LeftMouse>
    onoremap <M-LeftMouse> <C-C><4-LeftMouse>
    noremap  <M-LeftDrag>  <LeftDrag>
    inoremap <M-LeftDrag>  <LeftDrag>
    onoremap <M-LeftDrag>  <C-C><LeftDrag>


    " Deleting words and Entering insert mode
    call CreateShortcut("CR", "di<CR>", "v")
    call CreateShortcut("BS", "d", "v")
    call CreateShortcut("Space", "di<Space>", "v")
    call CreateShortcut("C-BS", "d", "v")
    call CreateShortcut("C-Del", "ldw", "i")
    call CreateShortcut("C-Del", "dw", "n")
    vnoremap a dia
    vnoremap b dib
    vnoremap c dic
    vnoremap d did
    vnoremap e die
    vnoremap f dif
    vnoremap g dig
    vnoremap h dih
    vnoremap i dii
    vnoremap j dij
    vnoremap k dik
    vnoremap l dil
    vnoremap m dim
    vnoremap n din
    vnoremap o dio
    vnoremap p dip
    vnoremap q diq
    vnoremap r dir
    vnoremap s dis
    vnoremap t dit
    vnoremap u diu
    vnoremap v div
    vnoremap w diw
    vnoremap x dix
    vnoremap y diy
    vnoremap z diz
    vnoremap A diA
    vnoremap B diB
    vnoremap C diC
    vnoremap D diD
    vnoremap E diE
    vnoremap F diF
    vnoremap G diG
    vnoremap H diH
    vnoremap I diI
    vnoremap J diJ
    vnoremap K diK
    vnoremap L diL
    vnoremap M diM
    vnoremap N diN
    vnoremap O diO
    vnoremap P diP
    vnoremap Q diQ
    vnoremap R diR
    vnoremap S diS
    vnoremap T diT
    vnoremap U diU
    vnoremap V diV
    vnoremap W diW
    vnoremap X diX
    vnoremap Y diY
    vnoremap Z diZ
    vnoremap 1 di1
    vnoremap 2 di2
    vnoremap 3 di3
    vnoremap 4 di4
    vnoremap 5 di5
    vnoremap 6 di6
    vnoremap 7 di7
    vnoremap 8 di8
    vnoremap 9 di9
endif

inoremap <C-h> <C-w>
nnoremap <C-h> db
cnoremap <C-h> <C-w>
""" Case insensitive when entering command mode
nnoremap : :set ignorecase<CR>:
nnoremap / :set ignorecase<CR>/
inoremap <C-BS> <C-W>
nnoremap <C-BS> db
cnoremap <C-BS> <C-w>
inoremap <C-_> <C-W>
nnoremap <C-_> i<C-W>
cnoremap <C-_> <C-w>
vnoremap <bar> <S-i>
inoremap {<CR> {<CR>}<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap (<CR> (<CR>)<ESC>O

function! ForceFoldmethodIndent()
    if &foldenable
        set foldmethod=indent
    endif
endfunction

" minus key is folding/unfolding code in normal mode
nnoremap <silent> - :normal zi<CR>:call ForceFoldmethodIndent()<CR>

" Highlight selected color
hi Visual term=reverse cterm=reverse gui=reverse guifg=#00afff guibg=White
" Highlight pop-up window color
hi Pmenu guifg=#00afff guibg=White
hi PmenuSel guifg=White guibg=#00afff
" Background color
hi Normal ctermfg=231 ctermbg=235 cterm=NONE guifg=#f8f8f2 guibg=#1B1D1E gui=NONE
hi Search cterm=NONE ctermfg=grey ctermbg=blue guibg=yellow guifg=black
hi IncSearch ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=underline
" Commenting blocks of code.
autocmd FileType c,cpp,java         let b:comment_leader = '\/\/'
autocmd FileType javascript         let b:comment_leader = '\/\/'
autocmd FileType arduino            let b:comment_leader = '\/\/'
autocmd FileType registry           let b:comment_leader = ';'
autocmd FileType dosbatch           let b:comment_leader = 'REM'
autocmd FileType sh,ruby,python     let b:comment_leader = '#'
autocmd FileType conf,fstab,zsh     let b:comment_leader = '#'
autocmd FileType make,Cmake         let b:comment_leader = '#'
autocmd FileType desktop            let b:comment_leader = '#'
autocmd FileType matlab,tex         let b:comment_leader = '%'
autocmd FileType vim                let b:comment_leader = '"'
autocmd FileType css                let b:comment_leader = '\/\*'   |   let b:comment_ender = '\*\/'
autocmd FileType html,xml           let b:comment_leader = '<!--'   |   let b:comment_ender = '-->'

function! ToggleComment()
  if exists('b:comment_leader')
    if getline('.') =~ '^' .b:comment_leader
      " uncomment the line
      execute 'silent s/^' .b:comment_leader.' //g'
      if exists('b:comment_ender')
        execute 'silent s/ ' .b:comment_ender.'$//g'
      endif
    elseif getline('.') =~ '^\s*$'
      " empty lines
    else
      " comment the line
      execute 'silent s/^/' .b:comment_leader.' /g'
      if exists('b:comment_ender')
        execute 'silent s/$/ ' .b:comment_ender.'/g'
      endif
    endif
  else
    echo 'No comment leader found for filetype'
  end
endfunction

function! ToggleComments()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  for i in range(lnum1, lnum2)
      if exists('b:comment_leader')
        if getline(i) =~ '^' .b:comment_leader
          " uncomment the line
          execute 'silent '.i.'s/^' .b:comment_leader.' //g'
          if exists('b:comment_ender')
            execute 'silent '.i.'s/ ' .b:comment_ender.'$//g'
          endif
        elseif getline(i) =~ '^\s*$'
          " empty lines
        else
          " comment the line
          execute 'silent '.i.'s/^/' .b:comment_leader.' /g'
          if exists('b:comment_ender')
            execute 'silent '.i.'s/$/\ ' .b:comment_ender.'/g'
          endif
        endif
      else
        echo 'No comment leader found for filetype'
      end
  endfor
endfunction

if !exists("*ReloadConfigs")
  function ReloadConfigs()
      :source $MYVIMRC
      if has("gui_running")
          :source $MYGVIMRC
      endif
  endfunction
endif

noremenu Edit.Encoding.UTF8      :e ++enc=utf-8<CR>
noremenu Edit.Encoding.UCS\ Bom  :e ++enc=ucs-bom<CR>
noremenu Edit.Encoding.Big5      :e ++enc=big5<CR>
noremenu Edit.Encoding.GBK       :e ++enc=gbk<CR>
noremenu Edit.Encoding.Japan     :e ++enc=japan<CR>
noremenu Edit.Encoding.Korea     :e ++enc=korea<CR>
noremenu Edit.Encoding.UTF16     :e ++enc=utf-16<CR>
noremenu Edit.Encoding.UTF16LE   :e ++enc=utf-16le<CR>
noremenu Edit.Encoding.UTF16BE   :e ++enc=utf-16be<CR>
noremenu Edit.Encoding.ANSI      :e ++enc=ansi<CR>

command! JsonPretty  execute "%!python -m json.tool"
command! PrettyJson  execute "%!python -m json.tool"
command! ReloadVimrc call ReloadConfigs()
command! EncodingUTF8    execute "e ++enc=utf-8"
command! EncodingUcsBom  execute "e ++enc=ucs-bom"
command! EncodingBig5    execute "e ++enc=big5"
command! EncodingGBK     execute "e ++enc=gbk"
command! EncodingJapan   execute "e ++enc=japan"
command! EncodingKorea   execute "e ++enc=korea"
command! EncodingUTF16   execute "e ++enc=utf-16"
command! EncodingUTF16LE execute "e ++enc=utf-16le"
command! EncodingUTF16BE execute "e ++enc=utf-16be"
command! EncodingAnsi    execute "e ++enc=ansi"
