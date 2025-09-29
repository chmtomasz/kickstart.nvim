return {
  'rcarriga/nvim-dap-ui',
  lazy = true,
  dependencies = { 'nvim-neotest/nvim-nio' },
  config = function()
    require('dapui').setup {}
  end,
}
