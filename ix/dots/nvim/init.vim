let s:vimplugpath="$HOME/.local/share/nvim/site/autoload/plug.vim"
let s:vimplugurl="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if !filereadable(expand(s:vimplugpath))
    execute "!curl -fLo " . s:vimplugpath . " --create-dirs " . s:vimplugurl
endif

call plug#begin('~/.config/nvim/plugged')
" Filetype
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'LnL7/vim-nix', { 'for': 'nix' }
Plug 'lervag/vimtex', { 'for': 'tex' }

" Frontend
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'

" Complete/Lint
Plug 'autozimu/LanguageClient-neovim', {
            \ 'for': ['rust', 'typescript'] ,
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'w0rp/ale', { 'for': ['sh', 'c', 'cpp', 'ruby', 'python', 'nix'] }
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
            \| Plug 'ncm2/ncm2-bufword'
            \| Plug 'ncm2/ncm2-path'
            \| Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'morhetz/gruvbox'
Plug 'cohama/lexima.vim'
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-obsession'
Plug 'kassio/neoterm'
call plug#end()

colorscheme gruvbox

set background=dark
set termguicolors
set number
set cursorline

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

nnoremap <space> <nop>
let mapleader="\<Space>"

inoremap fd <ESC>
tnoremap <ESC> <C-\><C-n>
tnoremap fd <C-\><C-n>

nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>wH <C-w>H
nnoremap <leader>wJ <C-w>J
nnoremap <leader>wK <C-w>K
nnoremap <leader>wL <C-w>L

nnoremap <leader>wv :vs<CR>
nnoremap <leader>ws :sp<CR>

nnoremap <leader>bq :quit<CR>
nnoremap <leader>bQ :quit!<CR>
nnoremap <leader>bw :write<CR>
nnoremap <leader>bs :wq<CR>

nnoremap <leader>be G
nnoremap <leader>bh gg

augroup augrp
    au!

    " Ruby indent
    au filetype ruby set tabstop=2
    au filetype ruby set shiftwidth=2
    au filetype ruby set softtabstop=2
    au filetype eruby set tabstop=2
    au filetype eruby set shiftwidth=2
    au filetype eruby set softtabstop=2

    " NASM
    au BufRead,BufNewFile *.nasm set filetype=nasm
augroup END

function! GetBufferList()
    redir =>buflist
    silent! ls!
    redir END
    return buflist
endfunction

function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:pfx.'close')
            return
        endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "Location List is Empty."
        return
    endif
    let winnr = winnr()
    exec(a:pfx.'open')
    if winnr() != winnr
        wincmd p
    endif
endfunction

command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction

nmap <silent> Q :QFix<CR>

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --ignore-case --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

command! -bang -nargs=* Rgc
            \ call fzf#vim#grep(
            \   'rg --case-sensitive --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

set clipboard+=unnamedplus

" let g:airline_section_z = airline#section#create(["L" . '%{line(".")}' . "C" . '%{col(".")}'])

set hidden

let g:LanguageClient_serverCommands = {
            \ 'typescript': ['javascript-typescript-stdio'],
            \ }
if executable('rls')
    let g:LanguageClient_serverCommands['rust'] = ['rls']
elseif executable('rustup')
    let g:LanguageClient_serverCommands['rust'] = ['rustup', 'run', 'stable', 'rls']
endif

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> \| :call LanguageClient_textDocument_formatting()<CR>

let g:ale_linters={
            \   'ruby': ['rubocop'],
            \   'rust': []
            \}
let g:ale_set_quickfix=1
let g:ale_nasm_nasm_options = '-felf64'

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

inoremap <silent> <buffer> <expr> <tab> ncm2_ultisnips#expand_or("\<tab>", 'n')

let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

let g:neoterm_autoinsert=1
nnoremap <silent> <leader>t :vertical rightbelow Ttoggle<CR>
