return {
  {
    "folke/twilight.nvim",
    event = "BufReadPre",
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#24283b" },
      }
    },
    config = function(_, opts)
      require("twilight").setup(opts)
    end,
  },
  { "folke/zen-mode.nvim", event = "BufReadPre" },
  {
    "epwalsh/obsidian.nvim",
    event = "BufEnter *.md",
    opts = {
      dir = "/home/piotr/public/Nextcloud/Documents/notes/obsidian-notes",
      notes_subdir = "Inbox",
      daily_notes = {
        folder = "Areas/Write/Daily",
      },
      note_frontmatter_func = function(note)
        local out = { id = note.id, created = note.metadata.created,
          aliases = note.aliases }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      vim.keymap.set(
        "n",
        "gf",
        function()
          if require('obsidian').util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
          else
            return "gf"
          end
        end,
        { noremap = false, expr = true }
      )
    end,
  },
}
