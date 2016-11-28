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

" keep all backup and swap files in common directory
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//

" automatically resize focused window
let &winwidth = 84

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
set t_Co=16
colorscheme solarized

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" precs <ctr> + s to save document
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
vmap <c-s> <Esc>:w<CR>

" switch between the last two files
nnoremap <leader><leader> <c-^>

" execute current ruby file
map <leader>r :!ruby %<cr>

" execute rubocop (style checker) for ruby
map <leader>R :!rubocop %<cr>

" spell check with <F4> and <F5>
map <F4> :setlocal spell! spelllang=en_gb<CR>
"map <F5> :setlocal spell spelllang=pl<CR>

" run ctrlp.vim plugin and set the shorcuts
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" turning Goyo plugin with a different key
map <F2> :Goyo <CR>

" syntax checker plugin settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" trim whitespace function
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
:noremap <Leader>w :call TrimWhitespace()<CR>

" change background between dark and light
function! ToggleBackground()
    if &background == "light"
        set background=dark
    else
        set background=light
    endif
endfunction
map <leader>b :call ToggleBackground()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !clear
  if match(a:filename, '\.feature$') != -1
    exec ":!bundle exec cucumber " . a:filename
  elseif match(a:filename, '_test\.rb$') != -1
    if filereadable("script/testrb")
      exec ":!script/testrb " . a:filename
    else
      exec ":!ruby -Itest " . a:filename
    end
  else
    if filereadable("Gemfile")
      exec ":!bundle exec rspec --color " . a:filename
    else
      exec ":!rspec --color " . a:filename
    end
  end
endfunction

function! SetTestFile()
  " set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

" run test runner
map <leader>t :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>T :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

