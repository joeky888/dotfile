set expandtab
set tabstop=4
set shiftwidth=4
set writebackup
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
set encoding=utf-8
set fileencodings=utf-8,big5,cp936,euc-jp,euc-kr,ucs-bom,utf-16le,default,latin1
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
highlight Normal guifg=white guibg=black
syntax on
set backspace=2
imap <C-BS> <C-W>
map  <C-Del> dw
imap <C-Del> <ESC>dwi
" colorscheme darkblue
" set number
" " set smartindent
" " set ai
" " imap { {}<ESC>i
" " imap [ []<ESC>i
" " imap ( ()<ESC>i
