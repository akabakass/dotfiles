local zone_status, zone = pcall(require, "zone")
if not zone_status then
  return
end

zone.setup({
  style = "dvd",
  after = 120
})
