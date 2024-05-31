-- use space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- set termguicolor to allow better coloration
vim.opt.termguicolors = true
-- resource that page on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "defaults.lua",
  group = vim.api.nvim_create_augroup("source_group", {clear = true}),
  command = "source <afile>"
})
-- set indentation to 2 spaces
-- length of actual \t character
vim.opt.tabstop = 2
-- -- length to use when editing text (0 = use tabstop value)
vim.opt.softtabstop = 2
-- -- length to use when shifting text with << or >> (0 = use tabstop value)
vim.opt.shiftwidth = 2
-- -- don't expand right amount of spaces into tab
vim.opt.expandtab = true
-- -- reproduce indentation of previous line
vim.opt.autoindent = true
-- -- try to be smart (increase indenting level after { for exemple)
vim.opt.smartindent = true
-- specific php indent to override vim weird default
vim.g['PHP_default_indenting'] = 2
-- -- show line number
vim.opt.number = true
-- show relative line number
vim.opt.relativenumber = true
-- show cursor position on bottom right
vim.opt.ruler = true
-- leave some context lines when scrolling down
vim.opt.scrolloff = 10
-- always use system clipboard
vim.opt.clipboard:append("unnamedplus")
-- set the tilde (changing case) as an operator to allow thing like ~iw that will change case on the all word
vim.opt.tildeop = true
-- allow movement keys to wrap to next line
vim.opt.whichwrap = "b,s,<,>,h,l"
-- show invisible characters
vim.opt.list = true
--define hint for invisible characters
vim.opt.listchars = {nbsp = "␣", tab = "->", trail = "."}
-- ask before re-loading content if file has been modified elsewhere
vim.opt.autoread = false
-- wrap long lines
vim.opt.linebreak = true
-- remove . from allowed characters to wrap long lines to avoid sql cut inside alias.column definition
vim.opt.breakat:remove(".")
-- continue wrapped line indented
vim.opt.breakindent = true
-- config for breakindent (shift = indent n more chars, sbr = show display showbreak chars before indent
vim.opt.breakindentopt = {shift = 4, 'sbr'}
-- set showbreak chars
vim.opt.showbreak = ">>>>"
-- show more lines in the command-line window
vim.opt.cmdwinheight = 15
-- show a line under active row
vim.opt.cursorline = true
-- Highlight the column of the cursor
vim.opt.cursorcolumn = true
-- show cursorcolumn and row only in the current window
vim.api.nvim_create_autocmd({'WinEnter', 'WinLeave'}, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("cursor_group", {clear = true}),
  callback = function(e)
    local status = false
    if e.event == "WinEnter" then
      status = true
    end
    vim.opt.cursorcolumn = status
    vim.opt.cursorline = status
  end
})
-- cursorline options (both = hl the line and the line number
vim.opt.cursorlineopt = "both"
-- try to open help files in french first
vim.opt.helplang = "fr,en"
-- hide buffers instead of unloading them
vim.opt.hidden = true
-- show cmd modification live and in a preview window at the same time
vim.opt.inccommand = "split"
-- remove highlighting of search which stay on after
vim.opt.hlsearch = false
-- highlight all search while searching, but remove highlighting when finished
vim.api.nvim_create_autocmd({"CmdlineEnter", "CmdlineLeave"}, {
  pattern = {"/", "\\?"}, -- only when entering cmd line with / (search) or ? (reverse-search)
  group = vim.api.nvim_create_augroup("hlsearch_toggle", {clear = true}),
  callback = function(e)
    local status = false
    if e.event == "CmdlineEnter" then
      status = true
    end
    vim.opt.hlsearch = status
  end
})
-- set mouse in all modes (normal, visual, insert, command-line and help files)
vim.opt.mouse = "a"
-- enable pseudo transparency for popup (right-click or completion likes) menus
vim.opt.pumblend = 10
-- open the new file in a split below the current one
vim.opt.splitbelow = true
-- open the new file in a vertical split on right of the current one
vim.opt.splitright = true
-- set undo file to keep undo when retuning to a already edited file
vim.opt.undofile = true
-- set undo file maximum changes that has been done. set a little high here cause it has saved me in the past to recover a file
vim.opt.undolevels = 10000
-- allow cursor to be positionned where there is no actual character on visual block mode
vim.opt.virtualedit = "block"
-- completion mode that is used on whildchar presses (<Tab> in my case)
-- I set it for first two consecutives presses
-- longest:full = expand to the longest common parts of the word, opening the popup menu
-- then full = scroll on the menu
vim.opt.wildmode = "longest:list,full"
-- activate wildmode menu
vim.opt.wildmenu = true
-- set pseudo-transparency for floating windows
vim.opt.winblend=10
-- no need to show things likd -- INSERT --
vim.opt.showmode = false
-- always show signcolumn to avoid text shifting
vim.opt.signcolumn = "yes"
-- add $ to make <cword> and when using motions
vim.opt.iskeyword:append("$")
-- don't have "o" add a comment
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  pattern = { "*" },
  callback = function()
    vim.opt_local.fo:remove("o")
    vim.opt_local.fo:remove("r")
  end,
})
