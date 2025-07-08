return {
  'mfussenegger/nvim-dap',
  lazy = true,
  config = function()
    local dap = require 'dap'
    -- Configure Python adapter using debugpy
    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          -- Use activated virtualenv or fallback to system python
          return os.getenv 'VIRTUAL_ENV' and (os.getenv 'VIRTUAL_ENV' .. '/bin/python') or 'python'
        end,
      },
    }
  end,
}
