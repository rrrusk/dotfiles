"NeoBundle {{{
 if has('vim_starting')
   set nocompatible               " Be iMproved

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck
" }}}

"neobundleプラグイン一覧{{{
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'yonchu/accelerated-smooth-scroll'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundleLazy 'mattn/emmet-vim', {
			\ 'insert' : 1,
			\ }
NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'taichouchou2/html5.vim'
NeoBundleLazy 'Shougo/neocomplete.vim', {
			\ 'depends' : ['Shougo/neosnippet'],
			\ 'insert' : 1,
			\ }
NeoBundleLazy 'Shougo/neosnippet', {
			\ 'depends' : ['honza/vim-snippets'],
			\ }
NeoBundleLazy 'Shougo/unite.vim', {
\ 'commands' : [{ 'name' : 'Unite',
\ 'complete' : 'customlist,unite#complete_source'},
\ 'UniteWithCursorWord', 'UniteWithInput']
\ }
NeoBundleLazy 'basyura/unite-rails'
NeoBundleLazy 'Shougo/neomru.vim'
NeoBundleLazy 'basyura/TweetVim', {
			\ 'depends' : ['basyura/twibill.vim', 'tyru/open-browser.vim'],
			\ 'commands' : 'TweetVimHomeTimeline',
			\ }
NeoBundle 'saihoooooooo/glowshi-ft.vim'
NeoBundleLazy 'mattn/vim-metarw-gdrive',{
			\ 'depends' : ['mattn/webapi-vim', 'kana/vim-metarw'],
			\ 'commands' : 'e gdrive:',
			\ }
NeoBundleLazy 'Shougo/vimshell.vim',{
			\ 'commands' : 'VimShell',
			\ }
" NeoBundle 'majutsushi/tagbar' "}}}

if neobundle#tap('neocomplete.vim') "{{{ NeoCompleteの設定コピペ
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
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

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif "}}} NeoCompleteコピペ終了

if neobundle#tap('neosnippet.vim') "{{{ neosnippetの設定コピペ
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif 

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'

" {{{Neosnipetの設定
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target) 
"}}} Neosnipetの設定

endif "}}}

if neobundle#tap('unite.vim') "{{{ unite.vim
let g:unite_enable_start_insert=1 "insertモードでスタート
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

call unite#custom#default_action('file' , 'tabopen') "ファイルは tabopen で開く
endif "}}}

"{{{カラースキーム railscasts
colorscheme railscasts
set t_Co=256 "}}}

"{{{タブをいい感じにするコピペ
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    <Space> [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

" tc 新しいタブを作る
nnoremap <silent> [Tag]c :tabnew<SPACE>
" tx タブを閉じる
nnoremap <silent> [Tag]x :tabclose<CR>
" tl 次のタブ
nnoremap <silent> [Tag]l :tabnext<CR>
" th 前のタブ
nnoremap <silent> [Tag]h :tabprevious<CR>
" tq ウインドウを閉じる
nnoremap <silent> [Tag]q :q<CR>
" tw 保存
nnoremap <silent> [Tag]w :w<CR> 
"}}}

"{{{ キーバインド
"コマンドキー入れ替え
noremap ; :
noremap : ;

"見た目上の行移動
noremap <C-n> gj
noremap <C-p> gk

"{{{一気にスクロール
map <C-j> <C-f>
map <C-k> <C-b>
map <C-h> <C-d>
map <C-l> <C-u> 
"}}}

" vimrcを開いたり読んだり
nnoremap <space>. :tabnew $MYVIMRC <CR>
nnoremap <leader>. :source $MYVIMRC <CR>

if neobundle#tap('emmet-vim') "{{{ emmetの設定
"ctrl + e で展開
 let g:user_emmet_expandabbr_key = '<c-e>'
"html展開した時のlangをjaに
 let g:user_emmet_settings = { 'lang' : 'ja'} 
endif "}}}emmet

if neobundle#tap('unite.vim') "{{{ uniteの設定
nnoremap <silent> <space>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <space>um :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> <space>uu :<C-u>Unite file<CR>
nnoremap <silent> <space>ur :Unite rails/
endif
"}}}
"}}}キーバインド

"新しい行のインデントを現在行と同じにする
set autoindent

"タブは半角4文字分のスペース
set ts=2 sw=2 sts=0

"行番号表示
set number

"編集中のファイル名を表示
set title

"カラー表示
syntax on

"Oで空行挿入
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

"clipboardにコピー
set clipboard=unnamed,unnamedplus

"<space> y,pで別のバッファから
nnoremap <space>y "ay
nnoremap <space>p "ap

"{{{改行コード
function! s:set_fileformat()
    if &fileformat != "unix"
\   && !get(b:, "set_fileformat_checked", 0)
\   && input("setlocal fileformat=unix?[y/n]") == "y"
        try
            setlocal fileformat=unix
        catch
        endtry
    endif
    let b:set_fileformat_checked = 1
endfunction

augroup vimrc_group_set_fileformat
    autocmd!
    autocmd BufWritePre * :call <SID>set_fileformat()
	augroup END "}}}


"<C-a>で増やすとき10進数扱い
set nrformats=

"改行コメントアウトなし
autocmd FileType * setlocal formatoptions-=ro

"{{{DiffOrig使用可能にする
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif "}}}

" swpファイルの場所変更
set directory=~/tmp

" ヘルプの言語変更
set helplang=ja,en

nnoremap <space>e :call Exe()<CR>
" vim: foldmethod=marker
