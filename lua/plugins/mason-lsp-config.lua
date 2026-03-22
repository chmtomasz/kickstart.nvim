return {
  'mason-org/mason-lspconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
}
