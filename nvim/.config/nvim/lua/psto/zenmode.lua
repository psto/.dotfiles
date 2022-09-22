local status_ok, zenmode = pcall(require, "zen-mode")
if not status_ok then
  return
end

zenmode.setup({
  window = {
    options = {
      relativenumber = false, -- disable relative numbers
      number = false, -- disable number column
      cursorline = false, -- disable cursorline
    },
    plugins = {
      twilight = { enabled = true }, -- start Twilight when zen mode opens
    },
  },
})
