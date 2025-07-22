return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    servers = {
      lua_ls = {},
      pyright = {},
      clangd = {},
    },
  },
  config = function(_, opts)
    local lspconfig = require 'lspconfig'
    require('lspconfig.ui.windows').default_options.border = 'rounded'

    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
