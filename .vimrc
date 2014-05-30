" ----------------------------------------------------------------------------------------
"   neobundle
" ----------------------------------------------------------------------------------------
set nocompatible               " Be iMproved

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
                \ 'windows' : 'make -f make_mingw32.mak',
                \ 'cygwin' : 'make -f make_cygwin.mak',
                \ 'mac' : 'make -f make_mac.mak',
                \ 'unix' : 'make -f make_unix.mak',
        \ },
\ }

filetype plugin indent on     " Required!

" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

"neobundle
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'yonchu/accelerated-smooth-scroll'

"カラースキーム
colorscheme railscasts
set t_Co=256

"タブをいい感じにする
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
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

nnoremap <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
nnoremap <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
nnoremap <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
nnoremap <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

"キーバインド
"括弧系押されたら自動で真ん中にソート
inoremap [] []<left>
inoremap <> <><left>
inoremap () ()<left>
inoremap {} {}<left>
inoremap "" ""<left>
inoremap '' ''<left>
inoremap 「」 「」<left>
inoremap </ </><left>
inoremap :; :<space>;<left>
"コマンドキー入れ替え
noremap ; :
noremap : ;

"新しい行のインデントを現在行と同じにする
set autoindent
"タブの代わりに空白文字を挿入する
"set expandtab
"タブは半角4文字分のスペース
set ts=2 sw=2 sts=0
"行番号表示
set number
"編集中のファイル名を表示
set title
"カラー表示
syntax on

"emmetの設定
"ctrl + e で展開
 let g:user_emmet_expandabbr_key = '<c-e>'

"html展開した時のlangをjaに
 let g:user_emmet_settings = { 'lang' : 'ja'}

"Oで空行挿入
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

"clipboardにコピー
set clipboard=unnamed,unnamedplus

"改行コード
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
augroup END

"一気にスクロール
nmap <C-j> <C-f>
nmap <C-k> <C-b>
nmap <C-h> <C-d>
nmap <C-l> <C-u>

"<C-a>で増やすとき10進数扱い
set nrformats=""
