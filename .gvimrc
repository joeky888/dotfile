set expandtab
set tabstop=4
set shiftwidth=4
set writebackup
set noerrorbells "disable error sound
set vb t_vb= "disable visualbell
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vmap <silent> <C-c> "+yi
vmap <silent> <C-x> "+xi
imap <silent> <C-v> <Esc>:call paste#Paste()<CR>a
nmap <silent> <C-v> <Esc>:call paste#Paste()<CR>a
"vmap <silent> <C-v> <Esc>:call paste#Paste()<CR>a
nmap <silent> <C-b> <Esc>:browse confirm saveas<CR>
vmap <silent> <C-b> <Esc>:browse confirm saveas<CR>
nmap <silent> <C-b> <Esc>:browse confirm saveas<CR>
imap <silent> <C-g> <Esc>ggVG<CR>
vmap <silent> <C-g> <Esc>ggVG<CR>
nmap <silent> <C-g> <Esc>ggVG<CR>
command! VisualBlock execute "normal! \<C-v>" 
imap <silent> <C-i> <Esc>l:VisualBlock<CR>
vmap <silent> <C-i> <Esc>:VisualBlock<CR>
nmap <silent> <C-i> <Esc>:VisualBlock<CR>
imap <silent> <F2> <Esc>:Te<CR>
nmap <silent> <F2> <Esc>:Te<CR>
vmap <silent> <F2> <Esc>:Te<CR>
imap <silent> <C-t> <Esc>:Te<CR>
nmap <silent> <C-t> <Esc>:Te<CR>
vmap <silent> <C-t> <Esc>:Te<CR>
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
set number
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,big5,shift-jis,gbk,cp950,cp936,utf-16le,default,latin1
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
map  <C-Del> dw
imap <C-Del> <ESC>ldiwi
nmap <C-Del> <ESC>diw
