local dashboard_status, dashboard = pcall(require, "dashboard")
if not dashboard_status then
  return
end

local ts_status, telescope = pcall(require, "telescope")
if not ts_status then
  return
end

local ts_builtin_status, builtin = pcall(require, "telescope.builtin")
if not ts_builtin_status then
  return
end

local ts_themes_status, themes = pcall(require, "telescope.themes")
if not ts_themes_status then
  return
end

require("telescope").load_extension "packer"
require("telescope").load_extension "repo"

local custom_center = {
  {
    icon = '🔍   ',
    desc = 'Find file in ' .. vim.fn.substitute(vim.fn.getcwd(), '/home/jc', '~', ''),
    action = function()
      builtin.find_files({
        cwd = vim.fn.substitute(vim.fn.getcwd(), '/home/jc', '~', ''),
        prompt_title = '🌞 ' .. vim.fn.substitute(vim.fn.getcwd(), '/home/jc', '~', ''),
        hidden = true
      })
    end
  },
  {
    icon = '💻   ',
    desc = 'Tubs dev',
    action = function()
      builtin.find_files({
        cwd = '/var/www/tubs',
        prompt_title = '💻 Tubs',
        hidden = true
      })
    end
  },
  {
    icon = '🔅   ',
    desc = 'Dotfiles         ',
    action = function()
      if pcall(function()
        builtin.git_files(
          themes.get_dropdown {
            cwd = '~/dotfiles',
            prompt_title = ' Dotfiles',
            hidden = true,
            previewer = false
          }
        )
      end) then
      else
        builtin.find_files(
          themes.get_dropdown {
            prompt_title = ' Dotfiles',
            cwd = '~/dotfiles',
            previewer = false,
            hidden = true
          }
        )
      end
    end
  },
    {
    icon = '🌵   ',
    desc = 'Git repos        ',
    action = function ()
      telescope.extensions.repo.list(
          themes.get_dropdown({
            prompt_title = '🌵 Git repos',
            previewer = false
        })
      )
    end
  },
  {
    icon = '🔌   ',
    desc = 'Plugins         ',
    action = function()
      telescope.extensions.packer.packer({
        
        prompt_title = '  Plugins',
        previewer = false
      })
    end
  },
  {
    icon = '📝   ',
    desc = 'New file        ',
    action = '<cmd>:enew<CR>'
  },
  {
    icon = '🔑   ',
    desc = 'Key maps        ',
    action = function()
      builtin.keymaps(
        themes.get_ivy({
          prompt_title = '👀 Key maps'
        })
      )
    end
  },
  {
    icon = '❓   ',
    desc = 'Help             ',
    action = function()
      builtin.help_tags(
        themes.get_dropdown({
          prompt_title = '❓ Help',
          previewer = false
        })
      )
    end
  }
}

dashboard.setup({
  -- config
  theme = "doom",
  config = {
    packages = {
      enable = true
    },
    center = custom_center
  }
})

