-- disable highlighting matching parens
vim.g.loaded_matchparen = 1

local g = vim.g     -- global variable
local cmd = vim.cmd -- command
local opt = vim.opt -- set options

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17 -- transparent popup
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
g.neovide_transparency = 0.8
g.transparency = 0.8
g.neovide_background_color = "#0f1117" .. alpha()

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1          -- Height of the command bar
opt.incsearch = true       -- Makes search act like search in modern browsers
opt.showmatch = true       -- show matching brackets when text indicator is over them
opt.showcmd = false        -- hide comands in the last line of screen
opt.relativenumber = true  -- Show line numbers
opt.number = true          -- But show the actual number for the line we're on
opt.ignorecase = true      -- Ignore case when searching...
opt.smartcase = true       -- ... unless there is a capital letter in the query
opt.hidden = true          -- I like having buffers stay around
opt.cursorline = true      -- Highlight the current line
opt.equalalways = false    -- I don't like my windows changing all the time
opt.splitright = true      -- Prefer windows splitting to the right
opt.splitbelow = true      -- Prefer windows splitting to the bottom
opt.updatetime = 1000      -- Make updates happen faster
opt.hlsearch = true        -- I wouldn't use this without the DoNoHL function
opt.scrolloff = 8          -- Make it so there are always ten lines below my cursor
opt.spelloptions = "camel" -- spell check camel case
opt.laststatus = 3         -- Show the status bar
opt.timeoutlen = 300       -- Time in milliseconds to wait for a mapped sequence to complete
opt.signcolumn = "yes"     -- Display sign column to not shift the layout with diagnostics signs
opt.jumpoptions = "stack"  -- Jumplist behaves like the tag stack

-- Tabs
-- opt.autoindent = true
-- opt.cindent = true
opt.wrap = true      -- wrap lines
opt.tabstop = 2      -- insert 2 spaces for a tab
opt.shiftwidth = 2   -- the number of spaces inserted for each indentation
opt.expandtab = true -- convert tabs to spaces

-- DISBALED for now because make large files slow
-- opt.breakindent = true
-- opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
-- opt.linebreak = true

opt.foldmethod = "expr"
opt.foldlevel = 0
opt.foldlevelstart = 99 --- Expand all folds by default
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "v:lua.vim.treesitter.foldtext()"
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split" -- interactive feedback with the substitute command with a preview window
opt.swapfile = false     -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

opt.formatoptions = opt.formatoptions
    - "a"                     -- Auto formatting is BAD.
    - "t"                     -- Don't auto format my code. I got linters for that.
    + "c"                     -- In general, I like it when comments respect textwidth
    + "q"                     -- Allow formatting comments w/ gq
    - "o"                     -- O and o, don't continue comments
    + "r"                     -- But do continue when pressing enter.
    + "n"                     -- Indent past the formatlistpat, not underneath it.
    + "j"                     -- Auto-remove comments if possible.
    - "2"                     -- I'm not in gradeschool anymore

opt.joinspaces = false        -- Two spaces and grade school, we're done
opt.fillchars = { eob = "~" } -- set fillchars=eob:~
opt.conceallevel = 1          -- concealing characters for obsidian.nvim

-- set grep to ripgrep
opt.grepprg = "rg --vimgrep --smart-case --hidden"
opt.grepformat = "%f:%l:%c:%m"

-- Netrw settings
g.netrw_banner = 0    -- remove the directory banner
g.netrw_winsize = 25  -- set width of the directory explorer to 25% of the page
g.netrw_liststyle = 3 -- set tree view type
-- avoid avoid loading netrw in favour of a tree plugin
g.loaded_netrwPlugin = 1
g.loaded_netrw = 1

-- Color
opt.colorcolumn = "80" -- hint to keep lines short
opt.termguicolors = true

-- approrpiately highlight codefences (codeblocks)
g.markdown_fenced_languages = { "css", "html", "javascript", "typescript", "lua", "vim" }
