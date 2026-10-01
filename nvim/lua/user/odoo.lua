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

    local out = {}        -- toute la sortie, gardee pour le rapport d'erreur
    local verdict = ""    -- la premiere etape : ce que le script a decide
    local pending = ""    -- morceau de ligne incomplet entre deux chunks
    local notif = nil     -- handle de notification, pour la remplacer

    local function step_notify(msg, level, final)
        -- nvim-notify renvoie un record qu'on repasse en 'replace' : la meme
        -- notification se met a jour au lieu d'en empiler une par etape.
        -- timeout=false sur les etapes car "replace" n'agit que sur une
        -- notification ENCORE OUVERTE ; le -u dure ~7 s et expirerait avant.
        local ok, res = pcall(vim.notify, msg, level or vim.log.levels.INFO, {
            title = "Odoo build",
            replace = notif,
            timeout = final and 4000 or false,
        })
        if ok then notif = res end
    end

    local function on_line(line)
        if line == "" then return end
        table.insert(out, line)
        local step = line:match("^>>%s*(.+)$")
        if step then
            if verdict == "" then verdict = step end
            step_notify("⏳ " .. step)
        end
    end

    -- stdout_buffered = false : les chunks arrivent au fil de l'eau, mais le
    -- dernier element d'un chunk peut etre une ligne incomplete, a recoller
    -- au chunk suivant.
    local function handler(_, data)
        if not data then return end
        for i, chunk in ipairs(data) do
            if i == #data then
                pending = pending .. chunk
            else
                on_line(pending .. chunk)
                pending = ""
            end
        end
    end

    vim.fn.jobstart({
        "sudo", "/home/jc/dotfiles/nvim/scripts/odoo_update.sh",
        filepath, detected_db, mode or "auto",
    }, {
        stdout_buffered = false,
        stderr_buffered = false,
        on_stdout = handler,
        on_stderr = handler,
        on_exit = function(_, code)
            if pending ~= "" then on_line(pending); pending = "" end
            if code == 0 then
                step_notify("✅ " .. verdict, nil, true)
            else
                step_notify("❌ echec (rc=" .. code .. ")", vim.log.levels.ERROR, true)
                local lines = vim.tbl_filter(function(l) return l ~= nil end, out)
                if #lines == 0 then lines = { "Echec (rc=" .. code .. ")" } end
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
