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
set ignorecase " case insensitive but case sensitive in command mode
let &showbreak="\u21aa " " Show a left arrow when wrapping text
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,big5,utf-16le,utf-16be,default,latin1
set synmaxcol=3000 " Don't try to highlight lines with over 3000 characters
set guioptions-=T " Don't show toolbar in Gvim
set guioptions+=b " Show bottom (horizontal) scrollbar in Gvim
let g:netrw_list_hide='' " Show all hidden files when usding vim explorer
let g:netrw_hide=0 " Show all hidden files when usding vim explorer
" Highlight code area in markdown
let g:markdown_fenced_languages = ["c","cpp","java","javascript","ruby","python","vim","css","html","xml","sh","conf","zsh","debsources","resolv","sudoers"]
" set iskeyword+=\- " Complete words containing a dash
" Open all cmd args in new tabs
execute ":silent tab all"
" Open help in new tabs
cnoreabbrev help <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tab help' : 'help')<CR>
cnoreabbrev h <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tab help' : 'h')<CR>

""" Prevent lag when hitting ESC
set ttimeoutlen=0
set timeoutlen=1000
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
    normal d
  elseif (c == "f" || c == "F")
    normal %
  elseif (c == "r" || c == "R")
    normal R
  elseif (c == "d" || c == "D")
    normal D
  endif
endfunction
function! PasteFromClipboard()
  if line(".") == 1
    normal O
    execute "r /tmp/clipboard.txt"
    execute "1d"
  else
    normal k
    execute "r /tmp/clipboard.txt"
  endif
endfunction
" Usefull shortcuts to enter insert mode
nnoremap <CR> i<CR>
nnoremap <Backspace> i<Backspace>
nnoremap <Space> i<Space>

" Backspace is deleting in visual mode
call CreateShortcut("BS", "d", "v")

" Ctrl A - Begin Line
call CreateShortcut("C-a", "0", "inv")

" Ctrl E - End Line
call CreateShortcut("C-e", "$l", "inv")

" Ctrl C - Copy
call CreateShortcut("C-c", "V:w! /tmp/clipboard.txt<CR>", "ni")
call CreateShortcut("C-c", ":w! /tmp/clipboard.txt<CR>", "v") " Vim still copy all lines of selection

" Ctrl X - Copy
call CreateShortcut("C-x", "V:w! /tmp/clipboard.txt<CR>gvd", "ni")
" Vim still cut all lines of selection
vnoremap <C-x> :w! /tmp/clipboard.txt<CR><ESC>:call DeleteSelectedLines()<CR>

" Ctrl V - Paste
call CreateShortcut("C-v", ":call PasteFromClipboard()<CR>", "ni")

" Ctrl S - Save
call CreateShortcut("C-s", ":call MySave()<CR>", "nv", "cmdInVisual", "restoreSelectionAfter")
call CreateShortcut("C-s", ":call MySave()<CR>a", "i", "noTrailingIInInsert")

" Home - Go To Begin
call CreateShortcut("Home", "gg", "inv")

" End - Go To End
call CreateShortcut("End", "G", "inv")

" Ctrl K - Delete Line
call CreateShortcut("C-k", "dd", "in")
vnoremap <C-k> <ESC>:call DeleteSelectedLines()<CR>

" Ctrl D - Duplicate Line
call CreateShortcut("C-d", "mjyyp`jjl", "i")
call CreateShortcut("C-d", "mjyyp`jj", "n")

" Ctrl Q - Visual block selection
call CreateShortcut("C-q", "<C-v>", "inv")

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

" Ctrl G - Select all
call CreateShortcut("C-g", "ggVG", "inv")

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

" Ctrl T - New tab
call CreateShortcut("C-t", ":tabnew<CR>i", "inv", "noTrailingIInInsert", "cmdInVisual")

" Alt Right - Next tab
call CreateShortcut("A-Right", "gt", "inv")

" Alt Left - Previous tab
call CreateShortcut("A-Left", "gT", "inv")

" Ctrl O - Netrw (:Explore)
call CreateShortcut("C-o",":call OpenNetrw()<CR>", "inv", "noTrailingIInInsert", "cmdInVisual")

let g:netrw_banner=0 " Hide banner
" let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' " Hide hidden files
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

function! DeleteSelectedLines()
  let l:lineBegin = line("'<")
  let l:lineEnd = line("'>")
  execute l:lineBegin.",".l:lineEnd."d"
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
set statusline+=%2*\ %{Modified()} " Modified Flags
set statusline+=%2*\ [%{&filetype}] " Filetype
set statusline+=%2*\ %{ReadOnly()} " ReadOnly Flags
set statusline+=%1*\ \%l/%L(%P)-%c\  " Position
" Speed up the redraw
au InsertLeave * call ChangeAccentColor()
au CursorHold * let &ro = &ro

"""" Color Scheme

"" Placed here for convenience.
"" Copied from sickill and tomasr Monokai on Github,
"" and slightly modified.

set background=dark
highlight clear
syntax reset
set t_Co=256
hi Green ctermfg=34 ctermbg=NONE cterm=NONE guifg=#00af00 guibg=NONE gui=NONE
hi iGreen ctermfg=0 ctermbg=34 cterm=NONE guifg=#000000 guibg=#00af00 gui=NONE
hi Cursor ctermfg=235 ctermbg=231 cterm=NONE guifg=#272822 guibg=#f8f8f0 gui=NONE
" Visual is selected color
hi Visual ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00afff gui=NONE
hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#293739 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#293739 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#293739 gui=NONE
hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#465457 guibg=#232526 gui=NONE
hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE
hi MatchParen ctermfg=197 ctermbg=NONE cterm=underline guifg=#f92672 guibg=NONE gui=underline
hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#f8f8f2 guibg=#64645e gui=NONE
" Pmenu is popup autocomplete color
hi Pmenu ctermfg=39 ctermbg=255 cterm=NONE guifg=#00afff guibg=White
hi PmenuSel ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00afff
hi Search ctermfg=yellow ctermbg=NONE cterm=NONE guibg=yellow guifg=black
hi IncSearch ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=161 ctermbg=NONE cterm=NONE guifg=#d7005f guibg=NONE gui=NONE
hi Folded ctermfg=242 ctermbg=235 cterm=NONE guifg=#7E8E91 guibg=#272822 gui=NONE
hi SignColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#293739 gui=NONE
" Normal is background color
hi Normal ctermfg=231 ctermbg=235 cterm=NONE guifg=#F8F8F2 guibg=#1B1D1E gui=NONE
hi Boolean ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Character ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Comment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#7E8E91 guibg=NONE gui=NONE
hi Conditional ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi DiffAdd ctermfg=231 ctermbg=64 cterm=bold guifg=#f8f8f2 guibg=#46830c gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8b0807 guibg=NONE gui=NONE
hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=#243955 gui=NONE
hi DiffText ctermfg=231 ctermbg=24 cterm=bold guifg=#f8f8f2 guibg=#204a87 gui=bold
hi Error ctermfg=219 ctermbg=89 cterm=NONE guifg=#E6DB74 guibg=#1E0010 gui=NONE
hi ErrorMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi WarningMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi Float ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Function ctermfg=148 ctermbg=NONE cterm=NONE guifg=#a6e22e guibg=NONE gui=NONE
hi Identifier ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi Keyword ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Label ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi Debug ctermfg=225 cterm=NONE guifg=#BCA3A3 gui=NONE
hi Exception ctermfg=118 cterm=NONE guifg=#A6E22E gui=NONE
hi FoldColumn ctermfg=67  ctermbg=16 guifg=#465457 guibg=#000000
hi Ignore ctermfg=244 ctermbg=232 guifg=#808080 guibg=bg
hi Macro ctermfg=39 guifg=#00afff gui=NONE
hi ModeMsg ctermfg=229 guifg=#E6DB74
hi NonText cterm=NONE gui=NONE
hi Question ctermfg=81 guifg=#66D9EF
hi Repeat ctermfg=161 cterm=NONE guifg=#F92672 gui=NONE
hi SpecialChar ctermfg=161 cterm=NONE guifg=#F92672 gui=NONE
hi Structure ctermfg=81 guifg=#66D9EF
hi TabLine guibg=#1B1D1E guifg=#808080 gui=none
hi Typedef ctermfg=81 guifg=#66D9EF
hi VisualNOS ctermbg=238 guibg=#403D3D
hi WildMenu ctermfg=81  ctermbg=16 guifg=#66D9EF guibg=#000000
hi iCursor guifg=#000000 guibg=#F8F8F0
hi Number ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Operator ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi PreProc ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Special ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=NONE gui=NONE
hi SpecialComment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#7E8E91 guibg=NONE gui=NONE
hi SpecialKey ctermfg=59 ctermbg=237 cterm=NONE guifg=#49483e guibg=#293739 gui=NONE
hi Statement ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi StorageClass ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi String ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi Tag ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE
hi Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#f8f8f2 guibg=NONE gui=bold
hi Todo ctermfg=95 ctermbg=NONE cterm=inverse,bold guifg=#7E8E91 guibg=NONE gui=inverse,bold
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
hi erubyComment ctermfg=95 ctermbg=NONE cterm=NONE guifg=#7E8E91 guibg=NONE gui=NONE
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

let g:CharSet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function! ToggleAutoComplete()
  if (g:autocomp == 0)
    let g:autocomp=1
    for l:char in split(g:CharSet, '\zs')
      execute "inoremap <silent> ".l:char." ".l:char."<ESC>a<C-x><C-p>"
    endfor
  else
    let g:autocomp=0
    for l:char in split(g:CharSet, '\zs')
      execute "inoremap <silent> ".l:char." ".l:char
    endfor
  endif
endfunction

set noerrorbells " disable error sound
autocmd VimEnter * set noerrorbells " disable error sound
set vb t_vb= " disable visualbell
set t_vb= " disable visualbell
autocmd VimEnter * set vb t_vb= " disable visualbell
set smartcase& " No smart
set nowrap " Don't wrap text
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
set iskeyword& " '-' should not be one of the keywords

function! SomeTime()
"   just waste some time bro!
endfunction

if has("gui_running")
    if has('win32') || has('win64')
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
    set guicursor=a:ver25-Cursor/lCursor-blinkon0 " disable cursor flashing
    set selection=exclusive " Don't select char under cursor
    set mouseshape+=v:beam,n:beam " set cursor shape as modern editors should be
    set scrolloff& " unset scroll values
    set sidescrolloff&
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

    " Ctrl C is copying line if there is no word seleted
    call CreateShortcut("C-c", "V\"+y", "in")
    call CreateShortcut("C-c", "\"+y", "v")
    cnoremap <C-c> <C-y>

    " Ctrl X is cutting line if there is no word seleted
    call CreateShortcut("C-x", "V\"+x", "in")
    call CreateShortcut("C-x", "\"+x", "v")
    cnoremap <C-x> <C-y><C-e><C-u>

    " Ctrl v is paste / override selected then paste
    call CreateShortcut("C-v", ":call paste#Paste()<CR>", "i")
    call CreateShortcut("C-v", "\"+gP", "n")
    call CreateShortcut("C-v", "d:call SomeTime()<CR>\"+gP", "v")
    cnoremap <C-v> <C-r>+

    " Meta LeftMouse is block selecting
    noremap  <M-LeftMouse> <4-LeftMouse>
    inoremap <M-LeftMouse> <4-LeftMouse>
    onoremap <M-LeftMouse> <C-C><4-LeftMouse>
    noremap  <M-LeftDrag>  <LeftDrag>
    inoremap <M-LeftDrag>  <LeftDrag>
    onoremap <M-LeftDrag>  <C-C><LeftDrag>

    " Deleting words and Entering insert mode
    call CreateShortcut("CR", "di<CR>", "v")
    call CreateShortcut("Space", "di<Space>", "v")
    call CreateShortcut("C-BS", "d", "v")
    call CreateShortcut("C-Del", "ldw", "i")
    call CreateShortcut("C-Del", "dw", "n")

    " Get into insert mode by pressing any keys in visual mode
    for b:char in split(g:CharSet, '\zs')
      execute "vnoremap ".b:char." di".b:char
    endfor
endif

function! WrapSelected(c1, c2)
  execute "normal `<i".a:c1
  execute "normal `>a".a:c2
endfunction

" Byobu key binding
call CreateShortcut("F2", ":tabnew<CR>", "inv")
call CreateShortcut("C-t", ":tabnew<CR>", "inv")
call CreateShortcut("F3", ":tabp<CR>", "inv")
call CreateShortcut("F4", ":tabn<CR>", "inv")

" Ctrl \ is toggling comments
call CreateShortcut("C-\\", ":call ToggleComments()<CR>", "inv")

inoremap <C-b> <C-w>
nnoremap <C-b> db
cnoremap <C-b> <C-w>

" Useful command mode mapping
cnoremap <C-w> <C-c>
cnoremap <C-k> <C-e><C-u>
cnoremap <C-f> <C-c>:noh<CR>/\c
cnoremap <C-r> <C-c>:noh<CR>:%s/\c
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

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

function! ForceFoldmethodIndent()
  if &foldenable
    set foldmethod=indent
  endif
endfunction

" minus key is folding/unfolding code in normal mode
nnoremap <silent> - :normal zi<CR>:call ForceFoldmethodIndent()<CR>

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
au FileType vim setlocal ts=2 sw=2 sts=2 " 2 spaces indent for vim files
au FileType c,cpp,java,javascript setlocal cindent " cindent for c-like files

function! JsonBeautify()
  execute "%!python -m json.tool"
endfunction

function! JsonMinify()
  set filetype=json
  filetype indent on
  execute "%s/\\s\\+$//e"
  execute "%left"
  normal! ggVGJ
endfunction

" Json pretty by python
au FileType json,javascript noremenu Edit.Json.Beautify  :call JsonBeautify()<CR>
au FileType json,javascript noremenu Edit.Json.Minify    :call JsonMinify()<CR>
au FileType json,javascript command! JsonBeautify    execute "call JsonBeautify()"
au FileType json,javascript command! JsonMinify      execute "call JsonMinify()"

" XML pretty by vim
function! XmlBeautify()
  call XmlMinify()
  execute "%s/></>\\r</e"
  normal! gg=G
endfunction

function! XmlMinify()
  set filetype=xml
  filetype indent on
  execute "%s/\\s\\+$//e"
  normal! ggVGJ
  execute "%s/>\\s\\+</></e"
  execute "%s/\\n//e"
  execute "%s/\\r//e"
endfunction

au FileType xml noremenu Edit.XML.Beautify  :call XmlBeautify()<CR>
au FileType xml noremenu Edit.XML.Minify    :call XmlMinify()<CR>
au FileType xml command! XmlBeautify    execute "call XmlBeautify()"
au FileType xml command! XmlMinify      execute "call XmlMinify()"

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
noremenu Edit.Encoding.UCS\ Bom  :e ++enc=ucs-bom<CR>
noremenu Edit.Encoding.Big5      :e ++enc=big5<CR>
noremenu Edit.Encoding.GBK       :e ++enc=gbk<CR>
noremenu Edit.Encoding.Japan     :e ++enc=japan<CR>
noremenu Edit.Encoding.Korea     :e ++enc=korea<CR>
noremenu Edit.Encoding.UTF16LE   :e ++enc=utf-16le<CR>
noremenu Edit.Encoding.UTF16BE   :e ++enc=utf-16be<CR>
noremenu Edit.Encoding.ANSI      :e ++enc=ansi<CR>

command! EncodingUTF8    execute "e ++enc=utf-8"
command! EncodingUcsBom  execute "e ++enc=ucs-bom"
command! EncodingBig5    execute "e ++enc=big5"
command! EncodingGBK     execute "e ++enc=gbk"
command! EncodingJapan   execute "e ++enc=japan"
command! EncodingKorea   execute "e ++enc=korea"
command! EncodingUTF16LE execute "e ++enc=utf-16le"
command! EncodingUTF16BE execute "e ++enc=utf-16be"
command! EncodingAnsi    execute "e ++enc=ansi"
