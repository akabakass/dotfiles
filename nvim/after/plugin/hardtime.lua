local hardtime_status, hardtime = pcall(require, "hardtime")
if hardtime_status then
  hardtime.setup({
    disable_mouse = false,
    restriction_mode = "hint"
  })
end
