return {
  "stevearc/profile.nvim",
  config = function ()
    local profile = require("profile")
    local should_profile = os.getenv("NVIM_PROFILE")
    if should_profile then
      profile.instrument_autocmds()
      if should_profile:lower():match("^start") then
        profile.start("*")
      else
        profile.instrument("*")
      end
    end

    local function toggle_profile()
      if profile.is_recording() then
        profile.stop()
        vim.ui.input({ prompt = "Save profileile to:", completion = "file", default = "profile.json" }, function(filename)
          if filename then
            profile.export(filename)
            vim.notify(string.format("Wrote %s", filename))
          end
        end)
      else
        profile.start("*")
      end
    end
    vim.keymap.set("", "<f1>", toggle_profile)

  end
}
