local dashboard_status, dashboard = pcall(require, "dashboard")
if not dashboard_status then
  return
end



dashboard.setup({
  -- config
  theme = "doom",
})
