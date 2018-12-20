let s:vimplugpath="$HOME/.local/share/nvim/site/autoload/plug.vim"
let s:vimplugurl="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if !filereadable(expand(s:vimplugpath))
    execute "!curl -fLo " . s:vimplugpath . " --create-dirs " . s:vimplugurl
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'
Plug 'cohama/lexima.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'w0rp/ale'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'wakatime/vim-wakatime'
Plug 'leafgarland/typescript-vim'
Plug 'LnL7/vim-nix'
Plug 'lervag/vimtex'
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

inoremap fd <ESC>
tnoremap <ESC> <C-\><C-n>
tnoremap fd <C-\><C-n>

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

let g:airline_section_z = airline#section#create(["L" . '%{line(".")}' . "C" . '%{col(".")}'])

set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

let g:ale_linters={
            \   'ruby': ['rubocop'],
            \   'rust': []
            \}
let g:ale_set_quickfix=1
let g:ale_nasm_nasm_options = '-felf64'

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
