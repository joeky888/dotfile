set expandtab
set tabstop=4
set shiftwidth=4
set writebackup
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vmap <silent> <C-S-c> "+yi
vmap <silent> <C-S-x> "+xi
imap <silent> <C-S-v> <Esc>:call paste#Paste()<CR>
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
" colorscheme darkblue
" set number
" " set smartindent
" " set ai
" " imap { {}<ESC>i
" " imap [ []<ESC>i
" " imap ( ()<ESC>i

set completeopt=menuone,noinsert,noselect,longest
set complete-=w,b,u,t,i
set shortmess+=c

let autocomp=0
imap <silent> <F12> <Esc>:call ToggleAutoComplete()<CR>
vmap <silent> <F12> <Esc>:call ToggleAutoComplete()<CR>
nmap <silent> <F12> <Esc>:call ToggleAutoComplete()<CR>

function! ToggleAutoComplete()
  if (g:autocomp == 0)
    let g:autocomp=1
    imap <silent> a a<Esc>:call AutoComplete()<CR>
    imap <silent> b b<Esc>:call AutoComplete()<CR>
    imap <silent> c c<Esc>:call AutoComplete()<CR>
    imap <silent> d d<Esc>:call AutoComplete()<CR>
    imap <silent> e e<Esc>:call AutoComplete()<CR>
    imap <silent> f f<Esc>:call AutoComplete()<CR>
    imap <silent> g g<Esc>:call AutoComplete()<CR>
    imap <silent> h h<Esc>:call AutoComplete()<CR>
    imap <silent> i i<Esc>:call AutoComplete()<CR>
    imap <silent> j j<Esc>:call AutoComplete()<CR>
    imap <silent> k k<Esc>:call AutoComplete()<CR>
    imap <silent> l l<Esc>:call AutoComplete()<CR>
    imap <silent> m m<Esc>:call AutoComplete()<CR>
    imap <silent> n n<Esc>:call AutoComplete()<CR>
    imap <silent> o o<Esc>:call AutoComplete()<CR>
    imap <silent> p p<Esc>:call AutoComplete()<CR>
    imap <silent> q q<Esc>:call AutoComplete()<CR>
    imap <silent> r r<Esc>:call AutoComplete()<CR>
    imap <silent> s s<Esc>:call AutoComplete()<CR>
    imap <silent> t t<Esc>:call AutoComplete()<CR>
    imap <silent> u u<Esc>:call AutoComplete()<CR>
    imap <silent> v v<Esc>:call AutoComplete()<CR>
    imap <silent> w w<Esc>:call AutoComplete()<CR>
    imap <silent> x x<Esc>:call AutoComplete()<CR>
    imap <silent> y y<Esc>:call AutoComplete()<CR>
    imap <silent> z z<Esc>:call AutoComplete()<CR>
    imap <silent> A A<Esc>:call AutoComplete()<CR>
    imap <silent> B B<Esc>:call AutoComplete()<CR>
    imap <silent> C C<Esc>:call AutoComplete()<CR>
    imap <silent> D D<Esc>:call AutoComplete()<CR>
    imap <silent> E E<Esc>:call AutoComplete()<CR>
    imap <silent> F F<Esc>:call AutoComplete()<CR>
    imap <silent> G G<Esc>:call AutoComplete()<CR>
    imap <silent> H H<Esc>:call AutoComplete()<CR>
    imap <silent> I I<Esc>:call AutoComplete()<CR>
    imap <silent> J J<Esc>:call AutoComplete()<CR>
    imap <silent> K K<Esc>:call AutoComplete()<CR>
    imap <silent> L L<Esc>:call AutoComplete()<CR>
    imap <silent> M M<Esc>:call AutoComplete()<CR>
    imap <silent> N N<Esc>:call AutoComplete()<CR>
    imap <silent> O O<Esc>:call AutoComplete()<CR>
    imap <silent> P P<Esc>:call AutoComplete()<CR>
    imap <silent> Q Q<Esc>:call AutoComplete()<CR>
    imap <silent> R R<Esc>:call AutoComplete()<CR>
    imap <silent> S S<Esc>:call AutoComplete()<CR>
    imap <silent> T T<Esc>:call AutoComplete()<CR>
    imap <silent> U U<Esc>:call AutoComplete()<CR>
    imap <silent> V V<Esc>:call AutoComplete()<CR>
    imap <silent> W W<Esc>:call AutoComplete()<CR>
    imap <silent> X X<Esc>:call AutoComplete()<CR>
    imap <silent> Y Y<Esc>:call AutoComplete()<CR>
    imap <silent> Z Z<Esc>:call AutoComplete()<CR>
  else
    let g:autocomp=0
    imap <silent> a a
    imap <silent> b b
    imap <silent> c c
    imap <silent> d d
    imap <silent> e e
    imap <silent> f f
    imap <silent> g g
    imap <silent> h h
    imap <silent> i i
    imap <silent> j j
    imap <silent> k k
    imap <silent> l l
    imap <silent> m m
    imap <silent> n n
    imap <silent> o o
    imap <silent> p p
    imap <silent> q q
    imap <silent> r r
    imap <silent> s s
    imap <silent> t t
    imap <silent> u u
    imap <silent> v v
    imap <silent> w w
    imap <silent> x x
    imap <silent> y y
    imap <silent> z z
    imap <silent> A A
    imap <silent> B B
    imap <silent> C C
    imap <silent> D D
    imap <silent> E E
    imap <silent> F F
    imap <silent> G G
    imap <silent> H H
    imap <silent> I I
    imap <silent> J J
    imap <silent> K K
    imap <silent> L L
    imap <silent> M M
    imap <silent> N N
    imap <silent> O O
    imap <silent> P P
    imap <silent> Q Q
    imap <silent> R R
    imap <silent> S S
    imap <silent> T T
    imap <silent> U U
    imap <silent> V V
    imap <silent> W W
    imap <silent> X X
    imap <silent> Y Y
    imap <silent> Z Z
  endif
  call feedkeys("a")
endfunction

function! AutoComplete()
  call feedkeys("a\<C-x>\<C-n>")
endfunction
