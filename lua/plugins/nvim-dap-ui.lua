return {
  'rcarriga/nvim-dap-ui',
  lazy = true,
  dependencies = { 'nvim-neotest/nvim-nio' },
  config = function()
    require('dapui').setup {}
  end,
  keys = {
    -- Optionally, you can also set keybindings here if preferred.
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'DAP UI: Toggle',
    },
  },
}
