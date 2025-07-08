-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {}
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
