return {
  'rcarriga/nvim-dap-ui',
  config = function()
    require('dapui').setup({})
  end,
  keys = {
    -- Optionally, you can also set keybindings here if preferred.
    { "<leader>du", function() require('dapui').toggle() end, desc = "DAP UI: Toggle" },
  },
}
