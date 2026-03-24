return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has 'nvim-0.7' == 1,
      -- Layouts define sections of the screen to place windows.
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = 'scopes', size = 0.25 },
            'breakpoints',
            'stacks',
            'watches',
          },
          size = 40, -- 40 columns
          position = 'left',
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 0.25, -- 25% of total lines
          position = 'bottom',
        },
      },
      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        -- Enables the following keymaps in dap ui:
        enabled = true,
        -- Display controls in this element
        element = 'repl',
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    }

    -- Automatically open and close the debugger UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Keymaps for dap ui
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
    vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Debug: Evaluate expression' })
    vim.keymap.set('v', '<leader>de', dapui.eval, { desc = 'Debug: Evaluate selection' })
    
    -- Window maximizing that properly restores the original buffer
    local maximized_state = {
      is_maximized = false,
      original_buffer = nil,
      original_cursor = nil
    }
    
    local function toggle_maximize_current_window()
      if maximized_state.is_maximized then
        -- Restore: reopen dap ui and restore original buffer
        vim.schedule(function()
          dapui.open()
          -- Wait a bit for dap ui to fully open, then restore original buffer
          vim.schedule(function()
            if maximized_state.original_buffer and vim.api.nvim_buf_is_valid(maximized_state.original_buffer) then
              -- Find a suitable window for the original buffer (usually the main editor window)
              local windows = vim.api.nvim_list_wins()
              for _, win in ipairs(windows) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
                -- Look for a window that can hold a normal file (not dap ui windows)
                if buftype == '' or buftype == 'acwrite' then
                  vim.api.nvim_win_set_buf(win, maximized_state.original_buffer)
                  vim.api.nvim_set_current_win(win)
                  if maximized_state.original_cursor then
                    vim.api.nvim_win_set_cursor(win, maximized_state.original_cursor)
                  end
                  break
                end
              end
            end
            maximized_state.original_buffer = nil
            maximized_state.original_cursor = nil
          end)
        end)
        maximized_state.is_maximized = false
        print("Debug layout restored")
      else
        -- Maximize: save current state
        local current_buf = vim.api.nvim_get_current_buf()
        local buftype = vim.api.nvim_buf_get_option(current_buf, 'buftype')
        
        -- Only save state if we're in a normal file buffer (not dap ui buffer)
        if buftype == '' or buftype == 'acwrite' then
          maximized_state.original_buffer = current_buf
          maximized_state.original_cursor = vim.api.nvim_win_get_cursor(0)
        end
        
        -- Close dap ui and maximize current window
        dapui.close()
        vim.cmd('only')
        
        maximized_state.is_maximized = true
        print("Window maximized")
      end
    end
    
    vim.keymap.set('n', '<leader>dm', toggle_maximize_current_window, { desc = 'Debug: Toggle maximize current window' })
  end,
}
