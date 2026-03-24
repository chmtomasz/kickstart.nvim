vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.conceallevel = 2

-- On Windows use PowerShell 7 (pwsh) as the shell to avoid cmd.exe overhead
-- for plugin-spawned subprocesses (git, formatters, etc.).
if vim.fn.has 'win32' == 1 and vim.fn.executable 'pwsh' == 1 then
  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
  vim.opt.shellxquote = ''
  vim.opt.shellquote = ''
end
