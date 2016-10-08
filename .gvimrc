set expandtab
set tabstop=4
set shiftwidth=4
set writebackup
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vmap <silent> <C-S-c> "+yi
vmap <silent> <C-S-x> "+xi
imap <silent> <C-S-v> <Esc>:call paste#Paste()<CR>
imap <silent> <C-S-s> <Esc>:browse confirm saveas<CR>
vmap <silent> <C-S-s> <Esc>:browse confirm saveas<CR>
nmap <silent> <C-S-s> <Esc>:browse confirm saveas<CR>
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
    else
        set guifont=Ubuntu\ Mono\ 14
    endif
endif
set guicursor=a:blinkon0
set nowrap
highlight Normal guifg=white guibg=black
syntax on
set backspace=2
imap <C-BS> <C-W>
map  <C-Del> dw
imap <C-Del> <ESC>dwi
