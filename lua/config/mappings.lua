-- Refactored, data-driven keymap registration with lazy-safe wrappers.

local M = {}

-- Helper to lazily require a module; returns a function that calls a field or passes module to callback.
local function lazy_require(mod, method_or_fn, notify)
	return function(...)
		local ok, lib = pcall(require, mod)
		if not ok then
			if notify ~= false then
				vim.notify(('Module %s not available'):format(mod), vim.log.levels.WARN)
			end
			return
		end
		if type(method_or_fn) == 'string' then
			local fn = lib[method_or_fn]
			if type(fn) == 'function' then
				return fn(...)
			end
			vim.notify(('Method %s missing in %s'):format(method_or_fn, mod), vim.log.levels.WARN)
		elseif type(method_or_fn) == 'function' then
			return method_or_fn(lib, ...)
		end
	end
end

-- Telescope wrapper builder
local function tb(method)
	return lazy_require('telescope.builtin', function(b) b[method]() end)
end

-- Telescope special: current buffer fuzzy finder with theme
local function telescope_buffer_fuzzy()
	local ok_builtin, builtin = pcall(require, 'telescope.builtin')
	if not ok_builtin then
		vim.notify('Telescope not available', vim.log.levels.WARN)
		return
	end
	local ok_theme, themes = pcall(require, 'telescope.themes')
	local dropdown = ok_theme and themes.get_dropdown { winblend = 10, previewer = true } or {}
	builtin.current_buffer_fuzzy_find(dropdown)
end

-- Structured keymap table.
-- Each entry: { mode(s), lhs, rhs|function, desc, opts? }
local mappings = {
	-- Core / UI
	{ 'n', '<tab>', '<cmd>BufferLineCycleNext<CR>', 'Next buffer' },
	{ 'n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>', 'Previous buffer' },
	{ 'n', '<C-s>', '<cmd>w<CR>', 'Save file' },
	{ 'n', '<Esc>', '<cmd>nohlsearch<CR>', 'Clear search highlight' },
	{ 'n', '<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist' },
	{ 't', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode' },
	{ 'n', '<C-h>', '<C-w><C-h>', 'Window left' },
	{ 'n', '<C-l>', '<C-w><C-l>', 'Window right' },
	{ 'n', '<C-j>', '<C-w><C-j>', 'Window down' },
	{ 'n', '<C-k>', '<C-w><C-k>', 'Window up' },
	{ 'n', '<leader>e', ':NvimTreeToggle<CR>', 'Toggle Nvim Tree' },
	{ 'n', '<leader>o', lazy_require('oil', 'toggle_float'), 'Oil float' },

	-- Formatting
	{ { 'n', 'v' }, '<leader>ll', function()
			lazy_require('conform', function(c)
				c.format { async = true, lsp_format = 'fallback' }
			end)()
		end, 'Format buffer/range' },

	-- DAP
	{ 'n', '<leader>dc', lazy_require('dap', 'continue'), 'DAP Continue' },
	{ 'n', '<leader>dn', lazy_require('dap', 'step_over'), 'DAP Step Over' },
	{ 'n', '<leader>di', lazy_require('dap', 'step_into'), 'DAP Step Into' },
	{ 'n', '<leader>dq', lazy_require('dap', 'step_out'), 'DAP Step Out' },
	{ 'n', '<leader>db', lazy_require('dap', 'toggle_breakpoint'), 'DAP Toggle Breakpoint' },
	{ 'n', '<leader>dr', lazy_require('dap', function(dap) dap.repl.open() end), 'DAP REPL' },
	{ 'n', '<leader>du', lazy_require('dapui', 'toggle'), 'DAP UI Toggle' },

	-- Harpoon
	{ 'n', '<leader>ba', lazy_require('harpoon.mark', 'add_file'), 'Harpoon add file' },
	{ 'n', '<leader>bb', lazy_require('harpoon.ui', 'toggle_quick_menu'), 'Harpoon quick menu' },

	-- Terminals
	{ 'n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', 'Terminal horizontal' },
	{ 'n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', 'Terminal float' },
	{ 'n', '<leader>h', function() require('toggleterm').toggle(1, nil, 'horizontal') end, 'Open horizontal terminal' },

	-- Git / Tools
	{ 'n', '<leader>lg', '<cmd>LazyGit<CR>', 'LazyGit' },


	-- Telescope family
	{ 'n', '<leader>fh', tb('help_tags'), 'Search Help' },
	{ 'n', '<leader>fk', tb('keymaps'), 'Search Keymaps' },
	{ 'n', '<leader>ff', tb('find_files'), 'Search Files' },
	{ 'n', '<leader>fs', tb('builtin'), 'Search Select Telescope' },
	{ 'n', '<leader>fw', tb('grep_string'), 'Search current Word' },
	{ 'n', '<leader>fg', tb('live_grep'), 'Search by Grep' },
	{ 'n', '<leader>fd', tb('diagnostics'), 'Search Diagnostics' },
	{ 'n', '<leader>fr', tb('resume'), 'Search Resume' },
	{ 'n', '<leader>f.', tb('oldfiles'), 'Search Recent Files' },
	{ 'n', '<leader><leader>', tb('buffers'), 'Search Buffers' },
	{ 'n', '<leader>/', telescope_buffer_fuzzy, 'Fuzzy in Buffer' },

	-- navigation
	{ 'n', '<leader>q', ':qa <CR>', 'Leave neovim' },
}

-- Apply all mappings
local function apply(tbl)
	for _, m in ipairs(tbl) do
		local mode, lhs, rhs, desc, opts = m[1], m[2], m[3], m[4], m.opts or {}
		opts.desc = desc
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

apply(mappings)

-- Optional which-key group registration (non-intrusive)
local function register_groups()
	local ok, wk = pcall(require, 'which-key')
	if not ok then return end
	wk.add {
		{ '<leader>d', group = 'DAP' },
		{ '<leader>b', group = 'Buffer / Harpoon' },
		{ '<leader>f', group = 'Find (Telescope)' },
		{ '<leader>t', group = 'Terminal' },
		{ '<leader>l', group = 'LSP/Format' },
		{ '<leader>cp', group = 'Copilot Chat' },
		{ '<leader>h', group = 'Git Hunk' }, -- gitsigns buffer local maps still added on attach
	}
end
register_groups()

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
