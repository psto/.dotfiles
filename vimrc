set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'ervandew/supertab'
Plugin 'lokaltog/vim-powerline'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/goyo.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tomtom/tcomment_vim'
" plugins for snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'

" run ctrlp.vim plugin and set the shorcuts
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" spell check with <F4> and <F5>
map <F4> :setlocal spell! spelllang=en_gb<CR>
"map <F5> :setlocal spell spelllang=pl<CR>

execute pathogen#infect()
filetype plugin indent on
set incsearch " show search results as I type
set ruler laststatus=2 number relativenumber title hlsearch ignorecase
set showmatch
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set wrap
set t_Co=256

"needed for vim solarized theme
syntax enable " show syntax highlighting
set background=light
let g:solarized_termcolors=256
colorscheme solarized

" turning Goyo plugin with a different key
map <F2> :Goyo <CR>

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" precs <ctr> + s to save document
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
vmap <c-s> <Esc>:w<CR>

" press 'j' twice to exit insert mode
imap jj <ESC>

" set up some custom colors
highlight clear SignColumn
highlight ColorColumn  ctermbg=237
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=red

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
  endif

" enable mouse selection
set mouse=a

" execute current ruby file
:map <leader>r :!ruby %<cr>

" trim whitespace function
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
:noremap <Leader>w :call TrimWhitespace()<CR>
