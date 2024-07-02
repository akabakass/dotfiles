return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { GitSignsAdd = "GitSignsAdd", text = "▎", GitSignsAddNr = "GitSignsAddNr", GitSignsAddLn = "GitSignsAddLn" },
      change = { GitSignsChange = "GitSignsChange", text = "▎", GitSignsChangeNr = "GitSignsChangeNr", GitSignsChangeLn = "GitSignsChangeLn" },
      delete = { GitSignsDelete = "GitSignsDelete", text = "契", GitSignsDeleteNr = "GitSignsDeleteNr", GitSignsDeleteLn = "GitSignsDeleteLn" },
      topdelete = { GitSignsTopdelete = "GitSignsDelete", text = "契", GitSignsTopdeleteNr = "GitSignsDeleteNr", GitSignsTopdeleteLn = "GitSignsDeleteLn" },
      changedelete = { GitSignsChangedelete = "GitSignsChange", text = "▎", GitSignsChangedeleteRn = "GitSignsChangeNr", GitSignsChangedeleteLn = "GitSignsChangeLn" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    current_line_blame = false,
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
      map('n', '<leader>hA', gs.stage_buffer, {desc = "add buffer"})
      map('n', '<leader>hr', gs.reset_hunk, {desc = "reset hunk"})
      map('n', '<leader>hu', gs.undo_stage_hunk, {desc = "undo stage hunk"})
      map('v', '<leader>ha', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc = "add hunk"})
      map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc = "reset hunk"})
    end
  },
  config = true
}
