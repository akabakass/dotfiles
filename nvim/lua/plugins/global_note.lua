return {
  "backdround/global-note.nvim",
  config = function()
    local global_note = require('global-note')

    -- UTILITIES
    local get_git_branch = function()
      local result = vim.fn.system("git symbolic-ref --short HEAD" )

      if result:find("^fatal") ~= nil then
        vim.notify(result, vim.log.levels.WARN)
        return nil
      end

      return result
    end

    local get_project_name = function()
      local result = vim.fn.system("git rev-parse --show-toplevel")

      if result:find("^fatal") ~= nil then
        vim.notify(result, vim.log.levels.WARN)
        return nil
      end

      local project_directory = result

      local project_name = vim.fs.basename(project_directory)
      if project_name == nil then
        vim.notify("Unable to get the project name", vim.log.levels.WARN)
        return nil
      end

      return project_name
    end

    -- SETUP
    global_note.setup({
      additional_presets = {
        git_branch_local = {
          command_name = "GitBranchNote",

          directory = function()
            return vim.fn.stdpath("data") .. "/global-note/" .. get_project_name()
          end,

          filename = function()
            local git_branch = get_git_branch()
            if git_branch == nil then
              return nil
            end
            return get_git_branch():gsub("[^%w-]", "-") .. ".md"
          end,
          title = get_git_branch
        }
      }
    })
    Key("n", "<leader>ln",
    function()
      global_note.toggle_note("git_branch_local")
    end,
    Opts("Toggle [L]ocal [N]otes")
    )

    Key('n', '<leader>gn',
      function()
        global_note.toggle_note()
      end,
      Opts("Toggle [G]lobal [N]otes"))
  end
}
