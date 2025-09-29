return {
  'DrKJeff16/project.nvim',
  lazy = true,
  ---@module 'project'

  ---@type Project.Config.Options
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  cond = vim.fn.has 'nvim-0.11' == 1, -- RECOMMENDED
}
