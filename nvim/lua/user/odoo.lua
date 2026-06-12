local function auto_build_odoo_module()
    -- 1. Chemin du fichier courant
    local filepath = vim.fn.expand('%:p')
    if filepath == "" then return print("⚠️ Aucun fichier ouvert.") end

    print("Recherche de la base active...")

    -- 2. Détection de la base active
    local handle = io.popen("sudo -u odoo /home/jc/dotfiles/nvim/scripts/get_active_db.py")
    if not handle then return print("❌ Erreur d'appel du script Python.") end
    local detected_db = handle:read("*a"):gsub("%s+", "")
    handle:close()

    if detected_db == "" then
        return print("⚠️ Impossible de détecter la base active. Êtes-vous connecté sur le navigateur ?")
    end

    print("Build Auto du module sur la BDD : " .. detected_db .. "...")

    -- 3. Lancement du build
    local out = {}
    vim.fn.jobstart({"sudo", "/home/jc/.config/nvim/scripts/odoo_update.sh", filepath, detected_db}, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, d) if d then vim.list_extend(out, d) end end,
        on_stderr = function(_, d) if d then vim.list_extend(out, d) end end,
        on_exit = function(_, code)
            if code == 0 then
                vim.notify("✅ Build OK sur " .. detected_db, vim.log.levels.INFO)
            else
                local lines = vim.tbl_filter(function(l) return l ~= nil end, out)
                if #lines == 0 then lines = {"Échec (rc=" .. code .. ") — rien capté, voir /var/log/odoo/odoo-server.log"} end
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

vim.keymap.set('n', '<leader>b', auto_build_odoo_module, { desc = "Odoo: Build auto sur la session active" })
