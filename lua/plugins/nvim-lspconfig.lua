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
    -- nvim-lspconfig >= 0.11 style: use vim.lsp.config()/vim.lsp.enable() rather than legacy lspconfig[server].setup.
    -- This keeps future removal of the old "framework" path trivial.
    local blink_cap = require('blink.cmp').get_lsp_capabilities
    local ok_ui, ui = pcall(require, 'lspconfig.ui.windows')
    if ok_ui then ui.default_options.border = 'rounded' end

    for server, user_cfg in pairs(opts.servers) do
      local cfg = vim.tbl_deep_extend('force', {}, user_cfg)
      cfg.capabilities = blink_cap(cfg.capabilities)

      -- Define (or extend) server configuration. Safe to call multiple times.
      -- If the user already defined vim.lsp.config(server, ...) elsewhere, this merges.
      pcall(vim.lsp.config, server, cfg)
    end

    -- Activate all configured servers for their matching filetypes.
    for server, _ in pairs(opts.servers) do
      -- Protected enable so missing configs don't raise hard errors.
      local ok = pcall(vim.lsp.enable, server)
      if not ok then
        vim.notify(('Failed to enable LSP server: %s'):format(server), vim.log.levels.WARN)
      end
    end
  end,
}
