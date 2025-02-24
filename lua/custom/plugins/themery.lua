return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require('themery').setup {
      themes = vim.fn.getcompletion('', 'color'),
      -- add the config here
    }
  end,
}
