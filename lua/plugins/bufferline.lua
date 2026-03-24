return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          separator = true, -- use a "true" to enable the default, or set your own character
        },
      },
    },
  },
}
