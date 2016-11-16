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
set autoindent " auto indent
inoremap <silent> <C-c> <Esc><S-v>"+yi
nnoremap <silent> <C-c> <Esc><S-v>"+yi
vnoremap <silent> <C-c> "+yi
vnoremap <silent> <C-x> "+xi
inoremap <silent> <C-v> <Esc>:call paste#Paste()<CR>i
nnoremap <silent> <C-v> <Esc>:call paste#Paste()<CR>i
vnoremap <silent> <C-v> dh"+pi
cnoremap <C-c> <C-y>
cnoremap <C-v> <C-r>+
cnoremap <C-x> <C-y><C-e><C-u>
cnoremap <S-Insert> <C-r>+
cnoremap <C-BS> <C-w>
cnoremap <C-w> <C-c>
cnoremap <C-k> <C-e><C-u>
cnoremap <C-f> <C-e><C-u>
inoremap <silent> <C-d> <Esc>yypA
nnoremap <silent> <C-d> <Esc>yypA
vnoremap <silent> <C-d> <Esc>yypA
inoremap <silent> <C-z> <Esc>ua
nnoremap <silent> <C-z> <Esc>ua
vnoremap <silent> <C-z> <Esc>ua
inoremap <silent> <S-Insert> <Esc>:call paste#Paste()<CR>i
nnoremap <silent> <S-Insert> <Esc>:call paste#Paste()<CR>i
vnoremap <silent> <S-Insert> dh"+pi
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
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
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
    set lines=999 columns=999 " set window Maximized
    set guicursor=n-v-c-ci-i:ver25-Cursor/lCursor
    set selection=exclusive " Don't select char under cursor
    set mouseshape+=v:beam,n:beam " set cursor shape as modern editors should be
    set guicursor=a:blinkon0
endif
set nowrap
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
set iskeyword& " '-' should not be one of the keywords
highlight Normal guifg=white guibg=black
syntax on
set backspace=2
inoremap <C-BS> <C-W>
nnoremap <C-BS> i<C-W>
vnoremap <C-BS> d
inoremap <C-Del> <ESC>ldwi
nnoremap <C-Del> <ESC>dwi
vnoremap <Space> di<Space>
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
vnoremap <bar> <S-i>
inoremap {<CR> {<CR>}<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap (<CR> (<CR>)<ESC>O

function! ForceFoldmethodIndent()
    if &foldenable
        set foldmethod=indent
    endif
endfunction

nnoremap <silent> - <ESC>:normal zi<CR>:call ForceFoldmethodIndent()<CR>
inoremap <silent> - <ESC>:normal zi<CR>:call ForceFoldmethodIndent()<CR>

" Highlight selected color
hi Visual term=reverse cterm=reverse gui=reverse guifg=#00afff guibg=White
" Highlight pop-up window color
hi Pmenu guifg=#00afff guibg=White
hi PmenuSel guifg=White guibg=#00afff

" Commenting blocks of code.
autocmd FileType c,cpp,java      let b:comment_leader = '\/\/'
autocmd FileType arduino         let b:comment_leader = '\/\/'
autocmd FileType sh,ruby,python  let b:comment_leader = '#'
autocmd FileType conf,fstab,zsh  let b:comment_leader = '#'
autocmd FileType make,Cmake      let b:comment_leader = '#'
autocmd FileType matlab,tex      let b:comment_leader = '%'
autocmd FileType vim             let b:comment_leader = '"'

function! ToggleComment()
  if exists('b:comment_leader')
    if getline('.') =~ '^' .b:comment_leader
      " uncomment the line
      execute 'silent s/^' .b:comment_leader.' //g'
    else
      " comment the line
      execute 'silent s/^/' .b:comment_leader.' /g'
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
        else
          " comment the line
          execute 'silent '.i.'s/^/' .b:comment_leader.' /g'
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

nnoremap <C-\> <ESC>:call ToggleComment()<CR>i
inoremap <C-\> <ESC>:call ToggleComment()<CR>i
vnoremap <C-\> <ESC>:call ToggleComments()<CR>i

noremenu Edit.Encoding.UTF8      <Esc>:e ++enc=utf-8<CR>
noremenu Edit.Encoding.UCS\ Bom  <Esc>:e ++enc=ucs-bom<CR>
noremenu Edit.Encoding.Big5      <Esc>:e ++enc=big5<CR>
noremenu Edit.Encoding.GBK       <Esc>:e ++enc=gbk<CR>
noremenu Edit.Encoding.Japan     <Esc>:e ++enc=japan<CR>
noremenu Edit.Encoding.Korea     <Esc>:e ++enc=korea<CR>
noremenu Edit.Encoding.UTF16     <Esc>:e ++enc=utf-16<CR>
noremenu Edit.Encoding.UTF16LE   <Esc>:e ++enc=utf-16le<CR>
noremenu Edit.Encoding.UTF16BE   <Esc>:e ++enc=utf-16be<CR>
noremenu Edit.Encoding.ANSI      <Esc>:e ++enc=ansi<CR>

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
