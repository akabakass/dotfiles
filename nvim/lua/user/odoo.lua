local function auto_build_odoo_module()
    -- 1. Récupération du chemin du fichier actuellement ouvert
    local filepath = vim.fn.expand('%:p')
    if filepath == "" then return print("⚠️ Aucun fichier ouvert.") end

    print("Recherche de la base active...")

    -- 2. Appel du script Python (avec l'usurpation d'identité odoo)
    -- On utilise exactement le chemin validé lors de vos tests
    local handle = io.popen("sudo -u odoo /home/jc/dotfiles/nvim/scripts/get_active_db.py")
    if not handle then return print("❌ Erreur d'appel du script Python.") end

    -- Lecture et nettoyage du retour (suppression des sauts de ligne)
    local detected_db = handle:read("*a"):gsub("%s+", "")
    handle:close()

    if detected_db == "" then
        return print("⚠️ Impossible de détecter la base active. Êtes-vous connecté sur le navigateur ?")
    end

    print("Build Auto du module sur la BDD : " .. detected_db .. "...")

    -- 3. Appel asynchrone du script Bash de build
    -- On utilise le chemin que vous aviez autorisé dans visudo
    vim.fn.jobstart({"sudo", "/home/jc/.config/nvim/scripts/odoo_update.sh", filepath, detected_db}, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data and data[1] ~= "" then
                -- Affiche les logs Odoo en direct dans Neovim
                vim.api.nvim_echo({{table.concat(data, '\n'), "Normal"}}, false, {})
            end
        end,
        on_exit = function(_, code)
            if code == 0 then
                vim.api.nvim_echo({{"✅ Build terminé sur " .. detected_db, "String"}}, false, {})
            else
                vim.api.nvim_echo({{"❌ Erreur lors du build (Code " .. code .. ")", "ErrorMsg"}}, false, {})
            end
        end
    })
end

-- Assigne l'action à la combinaison Espace + b (ou votre leader)
vim.keymap.set('n', '<leader>b', auto_build_odoo_module, { desc = "Odoo: Build auto sur la session active" })
