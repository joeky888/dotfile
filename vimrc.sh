# Linux /usr/share/vim OR /usr/share/vim/vimrc.tiny OR /etc/exrc OR ~/.exrc
set expandtab
set tabstop=4
set shiftwidth=4
set nobackup
set nowritebackup
set noswapfile
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
set nocompatible
set backspace=2
imap <C-BS> <C-W>
map  <C-Del> dw
imap <C-Del> <ESC>dwi
" set number
" set smartindent
" set ai
" syntax on
" imap { {}<ESC>i
" imap [ []<ESC>i
" imap ( ()<ESC>i

# Windows C:\Program Files\Vim\_vimrc
set expandtab
set tabstop=4
set shiftwidth=4
set backup
set backupdir=%TMP%
set backupskip=%TMP%
set directory=%TMP%
set writebackup
set undodir=%TMP%
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
set encoding=utf-8
set fileencodings=utf-8
set guifont=Consolas:h11
colorscheme darkblue
syntax on
set backspace=2
imap <C-BS> <C-W>
map  <C-Del> dw
imap <C-Del> <ESC>dwi
" set number
" set smartindent
" set ai
" imap { {}<ESC>i
" imap [ []<ESC>i
" imap ( ()<ESC>i