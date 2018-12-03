set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'nixprime/cpsm'
Plugin 'flazz/vim-colorschemes'
Plugin 'fatih/vim-go'
Plugin 'roosta/srcery'
" Plugin 'ervandew/supertab'
Plugin 'rking/ag.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'rust-lang/rust.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'leafgarland/typescript-vim'

" TypeScript LSP
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'ryanolsonx/vim-lsp-typescript'
call vundle#end()            " required
filetype plugin indent on    " required

" TypeScript LSP
if executable('typescript-language-server')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'typescript-language-server',
				\ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
				\ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
				\ 'whitelist': ['typescript'],
				\ })
endif

set clipboard=unnamed
set nocindent
set autoindent
:set expandtab
set tabstop=2
set shiftwidth=2
set pastetoggle=<C-e>

set t_Co=256
colorscheme desert
set background=dark
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
let g:ctrlp_user_command = 'files -a %s'
if executable('ag')
"  let g:ctrlp_use_caching=0 " Not to use cache
  let g:ctrlp_user_command='ag %s -i --hidden -g ""'
endif
" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" Vim-Go
au FileType go nmap gb <Plug>(go-build)
au FileType go nmap gt <Plug>(go-test)
au FileType go nmap gi <Plug>(go-iferr)
let g:go_fmt_command = "goimports"
set completeopt-=preview
autocmd FileType go :highlight goExtraVars cterm=bold ctermfg=136
autocmd FileType go :match goExtraVars /\<ok\>\|\<err\>/


" Ag
nnoremap \ :Ag<Space> 

" For Japanese English input switch
inoremap <silent> <C-j> <Nop>
inoremap <silent> <C-;> <Nop>

" Timestamp
nnoremap <F5> m'A<C-R>="\t".strftime('[%H:%M]')<CR><Esc>``

" neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? "\<C-y>" : "\<CR>"
" endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

set incsearch " incremental search
set hlsearch  " highlight
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR> " no hilight when esc is pressed twice

" easy replace
nnoremap sr :%s/\<<C-r><C-w>\>/


set swapfile
