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
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vmap <silent> <C-c> "+yi
vmap <silent> <C-x> "+xi
imap <silent> <C-v> <Esc>:call paste#Paste()<CR>a
nmap <silent> <C-v> <Esc>:call paste#Paste()<CR>a
vmap <silent> <C-v> <Esc>:call paste#Paste()<CR>a
cmap <C-v> <C-r>+
cmap <S-Insert> <C-R>+
imap <silent> <S-Insert> <Esc>:call paste#Paste()<CR>a
nmap <silent> <S-Insert> <Esc>:call paste#Paste()<CR>a
vmap <silent> <S-Insert> <Esc>:call paste#Paste()<CR>a
nmap <silent> <C-b> <Esc>:browse confirm saveas<CR>
vmap <silent> <C-b> <Esc>:browse confirm saveas<CR>
nmap <silent> <C-b> <Esc>:browse confirm saveas<CR>
imap <silent> <C-g> <Esc>ggVG<CR>
vmap <silent> <C-g> <Esc>ggVG<CR>
nmap <silent> <C-g> <Esc>ggVG<CR>
imap <silent> <F2> <Esc>:tabnew<CR>
nmap <silent> <F2> <Esc>:tabnew<CR>
vmap <silent> <F2> <Esc>:tabnew<CR>
imap <silent> <C-t> <Esc>:tabnew<CR>
nmap <silent> <C-t> <Esc>:tabnew<CR>
vmap <silent> <C-t> <Esc>:tabnew<CR>
imap <silent> <F3> <Esc>:tabp<CR>
nmap <silent> <F3> <Esc>:tabp<CR>
vmap <silent> <F3> <Esc>:tabp<CR>
imap <silent> <F4> <Esc>:tabn<CR>
nmap <silent> <F4> <Esc>:tabn<CR>
vmap <silent> <F4> <Esc>:tabn<CR>
vmap <silent> <BS> d
imap <silent> <C-o> <Esc>:browse confirm e<CR>
nmap <silent> <C-o> <Esc>:browse confirm e<CR>
vmap <silent> <C-o> <Esc>:browse confirm e<CR>
nmap <silent> <S-F1> <Esc>:e ++enc=utf-8<CR>
nmap <silent> <S-F2> <Esc>:e ++enc=ucs-bom<CR>
nmap <silent> <S-F3> <Esc>:e ++enc=big5<CR>
nmap <silent> <S-F4> <Esc>:e ++enc=shift-jis<CR>
nmap <silent> <S-F5> <Esc>:e ++enc=gbk<CR>
nmap <silent> <S-F6> <Esc>:e ++enc=cp950<CR>
nmap <silent> <S-F7> <Esc>:e ++enc=cp936<CR>
nmap <silent> <S-F8> <Esc>:e ++enc=utf-16le<CR>
nmap <silent> <S-F9> <Esc>:e ++enc=default<CR>
nmap <silent> <S-F10> <Esc>:e ++enc=latin1<CR>
noremap  <M-LeftMouse> <4-LeftMouse>
inoremap <M-LeftMouse> <4-LeftMouse>
onoremap <M-LeftMouse> <C-C><4-LeftMouse>
noremap  <M-LeftDrag>  <LeftDrag>
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
endif
set guicursor=a:blinkon0
set nowrap
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
highlight Normal guifg=white guibg=black
syntax on
set backspace=2
imap <C-BS> <C-W>
nmap <C-BS> i<C-W>
imap <C-Del> <ESC>ldwi
nmap <C-Del> <ESC>dwi
