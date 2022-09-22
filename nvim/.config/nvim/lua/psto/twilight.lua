local status_ok, twilight = pcall(require, "twilight")
if not status_ok then
  return
end

twilight.setup({
  dimming = {
    alpha = 0.25,
    color = { "Normal", "#24283b" },
  },
})
