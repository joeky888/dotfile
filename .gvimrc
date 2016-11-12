set expandtab
set tabstop=4
set shiftwidth=4
set writebackup
set noerrorbells "disable error sound
set vb t_vb= "disable visualbell
set scrolloff& " unset scroll values
set sidescrolloff&
set ignorecase " Search insensitive
set smartcase& " No smart
inoremap <silent> <C-c> <Esc><3-LeftMouse>"+yi
nnoremap <silent> <C-c> <Esc><3-LeftMouse>"+yi
vnoremap <silent> <C-c> "+yi
vnoremap <silent> <C-x> "+xi
inoremap <silent> <C-v> <Esc>"+pa
nnoremap <silent> <C-v> <Esc>"+pa
vnoremap <silent> <C-v> <Esc>"+pa
cnoremap <silent> <C-c> <C-y>
cnoremap <silent> <C-v> <C-r>+
cnoremap <silent> <C-x> <C-y><C-e><C-u>
cnoremap <silent> <S-Insert> <C-r>+
cnoremap <silent> <C-BS> <C-w>
cnoremap <silent> <C-w> <C-c>
cnoremap <silent> <C-k> <C-e><C-u>
inoremap <silent> <C-d> <Esc>yypA
nnoremap <silent> <C-d> <Esc>yypA
vnoremap <silent> <C-d> <Esc>yypA
inoremap <silent> <C-z> <Esc>ua
nnoremap <silent> <C-z> <Esc>ua
vnoremap <silent> <C-z> <Esc>ua
inoremap <silent> <S-Insert> <Esc>"+pa
nnoremap <silent> <S-Insert> <Esc>"+pa
vnoremap <silent> <S-Insert> <Esc>"+pa
nnoremap <silent> <C-b> <Esc>:browse confirm saveas<CR>
vnoremap <silent> <C-b> <Esc>:browse confirm saveas<CR>
inoremap <silent> <C-b> <Esc>:browse confirm saveas<CR>
inoremap <silent> <C-g> <Esc>ggVG<CR>
vnoremap <silent> <C-g> <Esc>ggVG<CR>
nnoremap <silent> <C-g> <Esc>ggVG<CR>
inoremap <silent> <F2> <Esc>:tabnew<CR>
nnoremap <silent> <F2> <Esc>:tabnew<CR>
vnoremap <silent> <F2> <Esc>:tabnew<CR>
inoremap <silent> <C-t> <Esc>:tabnew<CR>
nnoremap <silent> <C-t> <Esc>:tabnew<CR>
vnoremap <silent> <C-t> <Esc>:tabnew<CR>
inoremap <silent> <F3> <Esc>:tabp<CR>
nnoremap <silent> <F3> <Esc>:tabp<CR>
vnoremap <silent> <F3> <Esc>:tabp<CR>
inoremap <silent> <F4> <Esc>:tabn<CR>
nnoremap <silent> <F4> <Esc>:tabn<CR>
vnoremap <silent> <F4> <Esc>:tabn<CR>
vnoremap <silent> <BS> d
inoremap <silent> <C-o> <Esc>:browse confirm e<CR>
nnoremap <silent> <C-o> <Esc>:browse confirm e<CR>
vnoremap <silent> <C-o> <Esc>:browse confirm e<CR>
nnoremap <silent> <S-F1> <Esc>:e ++enc=utf-8<CR>
nnoremap <silent> <S-F2> <Esc>:e ++enc=ucs-bom<CR>
nnoremap <silent> <S-F3> <Esc>:e ++enc=big5<CR>
nnoremap <silent> <S-F4> <Esc>:e ++enc=shift-jis<CR>
nnoremap <silent> <S-F5> <Esc>:e ++enc=gbk<CR>
nnoremap <silent> <S-F6> <Esc>:e ++enc=cp950<CR>
nnoremap <silent> <S-F7> <Esc>:e ++enc=cp936<CR>
nnoremap <silent> <S-F8> <Esc>:e ++enc=utf-16le<CR>
nnoremap <silent> <S-F9> <Esc>:e ++enc=default<CR>
nnoremap <silent> <S-F10> <Esc>:e ++enc=latin1<CR>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
nnoremap  <M-LeftMouse> <4-LeftMouse>
inoremap <M-LeftMouse> <4-LeftMouse>
onoremap <M-LeftMouse> <C-C><4-LeftMouse>
nnoremap  <M-LeftDrag>  <LeftDrag>
inoremap <M-LeftDrag>  <LeftDrag>
onoremap <M-LeftDrag>  <C-C><LeftDrag>
set number
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,big5,shift-jis,cp950,cp936,utf-16le,default,latin1
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
    set lines=999 columns=999 " set window Maximized
    set guicursor=n-v-c-ci-i:ver25-Cursor/lCursor
    set selection=exclusive " Don't select char under cursor
endif
set guicursor=a:blinkon0
set nowrap
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
highlight Normal guifg=white guibg=black
syntax on
set backspace=2
inoremap <C-BS> <C-W>
nnoremap <C-BS> i<C-W>
inoremap <C-Del> <ESC>ldwi
nnoremap <C-Del> <ESC>dwi
set iskeyword-=-
" Highlight selected color
hi Visual term=reverse cterm=reverse gui=reverse guifg=#00afff guibg=White
" Highlight pop-up window color
hi Pmenu guifg=#00afff guibg=White
hi PmenuSel guifg=White guibg=#00afff
command JsonPretty execute "%!python -m json.tool"
