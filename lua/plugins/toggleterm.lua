return {
  'akinsho/toggleterm.nvim',
  version = '*',
  lazy = false,
  opts = {
    open_mapping = [[<c-\>]],
    direction = 'horizontal', -- default direction for ToggleTerm
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    float_opts = {
      border = 'curved',
      winblend = 3,
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- Terminal keymaps using the correct ToggleTerm command
    vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Toggle horizontal terminal' })
    vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', { desc = 'Toggle vertical terminal' })
    vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Toggle floating terminal' })
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=tab<cr>', { desc = 'Toggle terminal in new tab' })

    -- Quick access to specific terminals by number
    vim.keymap.set('n', '<leader>1', '<cmd>1ToggleTerm<cr>', { desc = 'Terminal 1' })
    vim.keymap.set('n', '<leader>2', '<cmd>2ToggleTerm<cr>', { desc = 'Terminal 2' })
    vim.keymap.set('n', '<leader>3', '<cmd>3ToggleTerm<cr>', { desc = 'Terminal 3' })

    -- Terminal mode keymaps for easy navigation
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- Apply terminal keymaps when terminal is opened
    vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
  end,
}
