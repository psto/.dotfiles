set nocompatible              " be iMproved, required
filetype off                  " required

" set leader key to comma
let mapleader = ","

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.nvim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
" disable plugins in codium/vscode when using vscode-neovim plugin
if !exists('g:vscode')
Plug 'mattn/emmet-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
" Plug 'ervandew/supertab'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'godlygeek/tabular'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'scrooloose/syntastic'
" Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
" Plug 'posva/vim-vue'
" Plug 'iCyMind/NeoSolarized'
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'jelera/vim-javascript-syntax'
Plug 'mustache/vim-mustache-handlebars'
Plug 'digitaltoad/vim-pug'
endif
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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
set splitbelow
" ignore certain files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" keep all backup and swap files in common directory
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
set undodir=~/..local/share/nvim/undo//

" fzf shorcut (exclude files in .gitignore)
nnoremap <silent> <C-p> :GFiles --cached --others --exclude-standard<cr>

" automatically resize focused window
"let &winwidth = 84

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
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,vue set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  " sets the filetype to html for .vue files,
  autocmd BufRead,BufNewFile *.vue setfiletype html

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  " autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=markdown

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et
augroup END

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Limelight integration with Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors

" Solarized light during the day, solarized dark during the night
" let hour = strftime("%H")
" if 6 <= hour && hour < 18
"   set background=light
" else
"   set background=dark
" endif

set background=dark
colorscheme dracula
" transparent background"
hi Normal guibg=NONE ctermbg=NONE

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
  " highlight ColorColumn ctermbg=0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

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

" clear last search highlighting
nnoremap <esc> :noh<return><esc>

" switch between the last two files
nnoremap <leader><leader> <c-^>

" Removing the directory banner
let g:netrw_banner = 0

" set width of directory explorer to 25% of the page
let g:netrw_winsize = 25

" toggle netrw
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Netrw shortcut
noremap <silent> <C-n> :call ToggleNetrw()<CR>

" execute current ruby file
map <leader>r :!clear;ruby %<cr>

" execute rubocop (style checker) for ruby
map <leader>R :!rubocop %<cr>

" spell check with <F4> and <F5>
map <F4> :setlocal spell! spelllang=en_gb<CR>
map <F5> :setlocal spell spelllang=pl<CR>

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

" coc.vim key maps
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" turn off when using coc.vim plugin
"
" function! InsertTabWrapper()
" let col = col('.') - 1
" if !col || getline('.')[col - 1] !~ '\k'
"     return "\<tab>"
" else
"     return "\<c-p>"
"     endif
" endfunction
" inoremap <expr> <tab> InsertTabWrapper()
" inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! RunTests(filename)
"   " Write the file and run tests for the given filename
"   :w
"   :silent !clear
"   if match(a:filename, '\.feature$') != -1
"     exec ":!bundle exec cucumber " . a:filename
"   elseif match(a:filename, '_test\.rb$') != -1
"     if filereadable("script/testrb")
"       exec ":!script/testrb " . a:filename
"     else
"       exec ":!ruby -Itest " . a:filename
"     end
"   else
"     if filereadable("Gemfile")
"       exec ":!bundle exec bin/rspec --color " . a:filename
"     else
"       exec ":!rspec --color " . a:filename
"     end
"   end
" endfunction
"
" function! SetTestFile()
"   " set the spec file that tests will be run for.
"   let t:grb_test_file=@%
" endfunction
"
" function! RunTestFile(...)
"   if a:0
"     let command_suffix = a:1
"   else
"     let command_suffix = ""
"   endif
"
"   " run the tests for the previously-marked file.
"   let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
"   if in_test_file
"     call SetTestFile()
"   elseif !exists("t:grb_test_file")
"     return
"   end
"   call RunTests(t:grb_test_file . command_suffix)
" endfunction
"
" function! RunNearestTest()
"   let spec_line_number = line('.')
"   call RunTestFile(":" . spec_line_number . " -b")
" endfunction
"
" " run test runner
" map <leader>t :call RunTestFile()<cr>
" " Run only the example under the cursor
" map <leader>T :call RunNearestTest()<cr>
" " Run all test files
" map <leader>a :call RunTests('spec')<cr>

""""""""""""""

" Fix strange character for insert in neoVim
:set guicursor=
