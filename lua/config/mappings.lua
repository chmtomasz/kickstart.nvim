vim.keymap.set('n', '<tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
-- add sace after clicking ctrl s
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })

-- oil
vim.keymap.set('n', '<leader>o', require('oil').toggle_float, { desc = 'Open oil float' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- New mapping for Nvim Tree toggle moved from plugin config.
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle Nvim Tree' })

-- DAP keybindings
vim.keymap.set('n', '<F5>', require('dap').continue, { desc = 'DAP: Continue' })
vim.keymap.set('n', '<F10>', require('dap').step_over, { desc = 'DAP: Step Over' })
vim.keymap.set('n', '<F11>', require('dap').step_into, { desc = 'DAP: Step Into' })
vim.keymap.set('n', '<F12>', require('dap').step_out, { desc = 'DAP: Step Out' })
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dr', require('dap').repl.open, { desc = 'DAP: Open REPL' })
vim.keymap.set('n', '<leader>ba', require('harpoon.mark').add_file, { desc = 'Harpoon: Add file to marks' })
vim.keymap.set('n', '<leader>bb', require('harpoon.ui').toggle_quick_menu, { desc = 'Harpoon: Toggle quick menu' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
