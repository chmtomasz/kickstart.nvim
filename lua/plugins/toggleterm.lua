return {
  'akinsho/toggleterm.nvim',
  version = '*',
  lazy = true,
  opts = {
    open_mapping = [[<c-\>]],
    direction = 'horizontal', -- default direction for ToggleTerm
  },
  keys = {
    { '<leader>h', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'Toggle horizontal terminal' },
    { '<leader>t', '<cmd>ToggleTerm direction=float<CR>', desc = 'Toggle floating terminal' },
  },
}
