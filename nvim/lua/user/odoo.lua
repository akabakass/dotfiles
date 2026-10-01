local function build(mode)
    local filepath = vim.fn.expand('%:p')
    if filepath == "" then return print("⚠️  Aucun fichier ouvert.") end

    local handle = io.popen("sudo -u odoo /home/jc/dotfiles/nvim/scripts/get_active_db.py")
    if not handle then return print("❌ Erreur d'appel du script Python.") end
    local detected_db = handle:read("*a"):gsub("%s+", "")
    handle:close()

    if detected_db == "" then
        return print("⚠️  Impossible de detecter la base active. Connecte sur le navigateur ?")
    end

    local out = {}
    vim.fn.jobstart({
        "sudo", "/home/jc/dotfiles/nvim/scripts/odoo_update.sh",
        filepath, detected_db, mode or "auto",
    }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, d) if d then vim.list_extend(out, d) end end,
        on_stderr = function(_, d) if d then vim.list_extend(out, d) end end,
        on_exit = function(_, code)
            -- La premiere ligne du script dit ce qu'il a decide et pourquoi.
            local verdict = out[1] or ""
            if code == 0 then
                vim.notify("✅ " .. verdict, vim.log.levels.INFO)
            else
                local lines = vim.tbl_filter(function(l) return l ~= nil end, out)
                if #lines == 0 then lines = {"Echec (rc=" .. code .. ")"} end
                vim.cmd("botright 18new")
                local buf = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                vim.bo[buf].buftype = "nofile"
                vim.bo[buf].bufhidden = "wipe"
                vim.bo[buf].filetype = "python"
                vim.bo[buf].modifiable = false
            end
        end,
    })
end

vim.keymap.set('n', '<leader>b', function() build("auto") end,
    { desc = "Odoo: build auto (detecte -u ou restart)" })
vim.keymap.set('n', '<leader>B', function() build("update") end,
    { desc = "Odoo: build force -u" })
vim.keymap.set('n', '<leader><leader>b', function() build("restart") end,
    { desc = "Odoo: restart seul, force" })
