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

require("telescope").load_extension "lazy"
require("telescope").load_extension "repo"
require('telescope').load_extension 'dap'

local custom_center = {
  {
    icon = "🖥️   ",
    desc = "select project",
    key = "p",
    action = function()
      require('telescope').extensions.projects.projects(
        require('telescope.themes').get_dropdown({
          hidden = true
        })
      )
    end
  },
  {
    icon = '🔍   ',
    desc = 'Find file in ' .. vim.fn.substitute(vim.fn.getcwd(), '/home/jc', '~', ''),
    key = 'f',
    action = function()
      require('telescope.builtin').find_files({
        cwd = vim.fn.substitute(vim.fn.getcwd(), '/home/jc', '~', ''),
        prompt_title = '🌞 ' .. vim.fn.substitute(vim.fn.getcwd(), '/home/jc', '~', ''),
        hidden = true
      })
    end
  },
  {
    icon = '💻   ',
    desc = 'Tubs dev',
    key = 't',
    action = function()
      require('telescope.builtin').find_files({
        cwd = '/var/www/tubs',
        prompt_title = '💻 Tubs',
        hidden = true
      })
    end
  },
  {
    icon = '🔅   ',
    desc = 'Dotfiles         ',
    key = 'd',
    action = function()
      if pcall(function()
        require('telescope.builtin').git_files(
          require('telescope.themes').get_dropdown {
            cwd = '~/dotfiles',
            prompt_title = ' Dotfiles',
            hidden = true,
            previewer = false
          }
        )
      end) then
      else
        require('telescope.builtin').find_files(
          require('telescope.themes').get_dropdown {
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
    key = 'g',
    action = function ()
      require('telescope').extensions.repo.list(
          require('telescope.themes').get_dropdown({
            prompt_title = '🌵 Git repos',
            previewer = false
        })
      )
    end
  },
  {
    icon = '🔌   ',
    desc = 'Plugins         ',
    key = '<C-p>',
    command = "Telescope lazy"
  },
  {
    icon = '📝   ',
    desc = 'New file        ',
    key = 'n',
    action = 'enew'
  },
  {
    icon = '🔑   ',
    desc = 'Key maps        ',
    key = 'm',
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
    key = 'h',
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

