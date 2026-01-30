return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local npairs = require("nvim-autopairs")

      npairs.setup({
        check_ts = true,
        map_cr = true,
      })

      local Rule = require('nvim-autopairs.rule')
      local cond = require('nvim-autopairs.conds')

--      npairs.add_rules({
--        Rule(">", "<", { "xml", "html" })
--          :with_pair(cond.none()) -- CRUCIAL : Interdit d'ajouter le '<' automatiquement
--          :with_move(cond.none()) -- Ne pas bouger le curseur
--          :with_cr(cond.done())   -- SEULE action autorisée : Gérer la touche Entrée
--      })
    end
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = false, -- On force le chargement immédiat (pas d'event) pour être sûr
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Setup vide pour commencer, ça utilise les défauts qui marchent
      require('nvim-ts-autotag').setup()
    end
  }
}
