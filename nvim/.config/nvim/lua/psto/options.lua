-- disable highlighting matching parens
vim.g.loaded_matchparen = 1

local g = vim.g -- global variable
local cmd = vim.cmd -- command
local opt = vim.opt -- set options

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17 -- transparent popup
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = true -- I like having buffers stay around
opt.cursorline = false -- Highlight the current line
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without the DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

-- opt.foldmethod = "marker"
-- opt.foldlevel = 0
opt.foldlevelstart = 99 --- Expand all folds by default
opt.foldtext = "CustomFold()" --- Emit custom function for foldtext
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split" -- interactive feedback with the substitute command with a preview window
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

opt.formatoptions = opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

-- Netrw settings
g.netrw_banner = 0 -- remove the directory banner
g.netrw_winsize = 25 -- set width of the directory explorer to 25% of the page
g.netrw_liststyle = 3 -- set tree view type
-- hide gitignore
-- g.netrw_list_hide=netrw_gitignore#Hide()
-- g.netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

-- do I need this?
g.completion_trigger_character = "."

--
-- COLOR
--
opt.colorcolumn = "80" -- hint to keep lines short
opt.termguicolors = true
-- terminal transparency can be set with picom, so not needed for now
-- cmd("au ColorScheme * hi Normal ctermbg=none guibg=none") -- transparent background

--
-- CUSTOM AUTOCMDS
--
-- waiting for vim.api.nvim_define_autocmd https://github.com/neovim/neovim/pull/14661
cmd([[
  augroup vimrcEx
    " Clear all autocmds in the group
    autocmd!
    autocmd FileType text setlocal textwidth=78
    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,typescript,javascriptreact,typescriptreact,sass,cucumber,vue,lua set ai sw=2 sts=2 et
    autocmd FileType python set sw=4 sts=4 et

    " sets the filetype to html for .vue files,
    " autocmd BufRead,BufNewFile *.vue setfiletype html
    autocmd BufReadPost,BufNewFile *.vue setlocal filetype=vue
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
    autocmd! BufNewFile,BufRead *.md setlocal ft=markdown

    " fish
    au BufNewFile,BufRead *.fish set filetype=fish
  augroup END
]])

-- automatically rebalance windows on vim resize
cmd([[autocmd VimResized * :wincmd =]])

--
-- Custom Folds, make them look better
--
cmd([[
  function! CustomFold()
    return printf('   %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
  endfunction
]])
-- It manages folds automatically based on treesitter
local parsers = require("nvim-treesitter.parsers")
local configs = parsers.get_parser_configs()
local ft_str = table.concat(
	vim.tbl_map(function(ft)
		return configs[ft].filetype or ft
	end, parsers.available_parsers()),
	","
)
print()
cmd("autocmd Filetype " .. ft_str .. " setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()")

-- format on save and quit
cmd([[cabbrev wq execute "lua vim.lsp.buf.formatting_seq_sync()" <bar> wq]])
