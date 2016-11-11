set nocompatible              " be iMproved, required
filetype off                  " required

" set leader key to comma
let mapleader = ","

" initialize pathogen
execute pathogen#infect()

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'mattn/emmet-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'ervandew/supertab'
Plugin 'junegunn/goyo.vim'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
" required by snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable mouse selection
set mouse=a
" vim can access system clipboard to copy/paste
set clipboard=unnamedplus
" enable highlighting for syntax
syntax on
" enable file type detection.
filetype plugin indent on
" enable relative number ruler
set ruler laststatus=2 number relativenumber title
set smarttab
set wrap
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set showmatch
" show search results as I type
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" show spaces
set listchars=tab:▸\ ,nbsp:⋅,trail:⋅
set list

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et
augroup END

" keep all backup and swap files in common directory
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//

" run ctrlp.vim plugin and set the shorcuts
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" vim can access system clipboard to copy/paste
set clipboard=unnamed

" spell check with <F4> and <F5>
map <F4> :setlocal spell! spelllang=en_gb<CR>
"map <F5> :setlocal spell spelllang=pl<CR>

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

" switch between the last two files
nnoremap <leader><leader> <c-^>

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

" syntax checker plugin settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" execute current ruby file
:map <leader>r :!ruby %<cr>

" execute rubocop (style checker) for ruby
map <leader>R :!rubocop %<cr>

" trim whitespace function
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
:noremap <Leader>w :call TrimWhitespace()<CR>
