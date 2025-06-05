return {
  'nvim-treek/nvim-tree.lua',
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      side = 'left',
      width = 30,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      icons = {
        glyphs = {
          default   = "",
          symlink   = "",
          folder    = {
            arrow_open   = "",
            arrow_closed = "",
            default      = "",
            open         = "",
          },
          git = {
            unstaged  = "✗",
            staged    = "✓",
            unmerged  = "",
            renamed   = "➜",
            untracked = "★",
          },
        },
      },
    },
  },
}
