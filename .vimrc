
"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'fatih/vim-go'
NeoBundle 'ervandew/supertab'
NeoBundle 'rking/ag.vim'
NeoBundle 'vimwiki/vimwiki.git'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

set clipboard=unnamed
set nocindent
set autoindent
:set expandtab
set tabstop=2
set shiftwidth=2
set pastetoggle=<C-e>

set t_Co=256
colorschem desert
"if you enable pase, doen't work autocomplete.
"set paste

filetype on
filetype indent on
filetype plugin on

"set fileencodings=iso-2022-jp,utf-8,euc-jp,ucs-2le,ucs-2,cp932
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

set ruler
set textwidth=0
set suffixes=.bak,‾,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

syntax on

set modelines=0
set smartindent
set ignorecase
set smartcase
set showcmd
set showmatch

set nohlsearch
set laststatus=2

set wildmode=list:longest
set hidden
set autoread

:set number

"jumping around windows
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

"jumpping buffers
nmap <C-P> :bp<CR>
nmap <C-N> :bn<CR>
"nmap <C-M> :make<up>

"compiler tag jump
nmap <Space>p :cp<CR>
nmap <Space>n :cn<CR>

nmap <Space>b :ls<CR>:buffer

set nobackup 

if has("syntax")
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "ﾃδ｣ﾃやぎﾃやぎ" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=Blue
        syntax match InvisibleTrailedSpace "[ ¥t]¥+$" display containedin=ALL
        highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
        syntax match InvisibleTab "¥t" display containedin=ALL
        highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan
    endf

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

set ruler

noremap j gj
noremap k gk
noremap gj j
noremap gk k

function! s:ExecuteCommandOnCR(command)
  if &buftype == ''
    execute a:command
  else
    call feedkeys("\r", 'n')
  endif
endfunction

"mustache filetype
au BufRead,BufNewFile *.mustache set filetype=html

let g:neocomplcache_enable_at_startup = 1

exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Ctrol-P
" Prefix: s
nnoremap s <Nop>
nnoremap sa :<C-u>CtrlP<Space>
nnoremap sb :<C-u>CtrlPBuffer<CR>
nnoremap sd :<C-u>CtrlPDir<CR>
nnoremap sf :<C-u>CtrlP<CR>
nnoremap sl :<C-u>CtrlPLine<CR>
nnoremap sm :<C-u>CtrlPMRUFiles<CR>
nnoremap sq :<C-u>CtrlPQuickfix<CR>
nnoremap ss :<C-u>CtrlPMixed<CR>
nnoremap st :<C-u>CtrlPTag<CR>

" Spell check
nnoremap sc :<C-u>setlocal spell spelllang=en_us<CR>
nnoremap sn :<C-u>set nospell<CR>

let g:ctrlp_map = '<Nop>'
" Guess vcs root dir
let g:ctrlp_working_path_mode = 'ra'
" Open new file in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'

" Vim-Go
au FileType go nmap gb <Plug>(go-build)
au FileType go nmap gt <Plug>(go-test)
let g:go_fmt_command = "goimports"
set completeopt-=preview

" Ag
nnoremap \ :Ag<Space> 

" For Japanese English input switch
inoremap <silent> <C-j> <Nop>
inoremap <silent> <C-;> <Nop>

" Timestamp
nnoremap <F5> m'A<C-R>="\t".strftime('[%H:%M]')<CR><Esc>``

