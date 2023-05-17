local gitsigns_status, gitsigns = pcall(require, "gitsigns")
if not gitsigns_status then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  current_line_blame = true,
    current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', 'gj', gs.next_hunk, {desc = "goto next hunk"})
    map('n', 'gk', gs.prev_hunk, {desc = "goto prev hunk"})
    map('n', 'gp', gs.preview_hunk, {desc = "show hunk preview"})
    map('n', '<leader>ha', gs.stage_hunk, {desc = "add hunk"})
    map('n', '<leader>hr', gs.reset_hunk, {desc = "reset hunk"})
    map('v', '<leader>ha', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc = "add hunk"})
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc = "reset hunk"})
})
