# Neovim Config — Copilot Instructions

This is a personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), restructured into a modular layout on Windows (`%LOCALAPPDATA%\nvim`).

## Linting

Lua formatting is enforced by **StyLua** (checked in CI via `stylua --check .`).

```sh
# Check formatting
stylua --check .

# Auto-fix formatting
stylua .
```

StyLua config (`.stylua.toml`): 2-space indent, 160-column width, single quotes preferred, no call parentheses.

## Architecture

```
init.lua                  ← Entry point: loads config, bootstraps lazy.nvim, imports plugins
lua/config/
  main_config.lua         ← All vim.opt/vim.g options; leader key set to <Space>
  mappings.lua            ← All keymaps in a single data-driven table
lua/plugins/              ← One file per plugin, each returns a lazy.nvim plugin spec
lua/kickstart/            ← Upstream kickstart helpers (health.lua)
lua/archive/              ← Disabled/experimental plugin configs (not loaded)
```

`init.lua` loads plugins via `{ import = 'plugins' }`, which picks up every file in `lua/plugins/`.

## Key Conventions

### Plugin files
Each file in `lua/plugins/` returns a single lazy.nvim spec table:
```lua
return {
  'owner/repo',
  event = { 'BufReadPost' },
  opts = { ... },
}
```

### Keymaps
All keymaps live in `lua/config/mappings.lua` as a flat table of `{ mode, lhs, rhs, desc }` entries — **do not use `vim.keymap.set` calls scattered across plugin files**.

The `lazy_require(mod, method_or_fn)` helper in `mappings.lua` creates lazy-safe callbacks that won't error if a plugin hasn't loaded yet. Use it for all keymap RHS functions that call into plugins.

### LSP setup
Uses the **new-style nvim-lspconfig API** (`vim.lsp.config()` / `vim.lsp.enable()`), not the legacy `lspconfig[server].setup()`. Add new servers to `opts.servers` in `lua/plugins/nvim-lspconfig.lua`. Capabilities are injected from `blink.cmp`.

### Formatting
**conform.nvim** auto-formats on save. `stylua` handles Lua; LSP format fallback is used for everything else. LSP formatting is explicitly disabled for `c` and `cpp` filetypes.

### Adding a new plugin
Create a new file `lua/plugins/<name>.lua` returning a lazy.nvim spec. It will be auto-imported. If it needs keymaps, add them to the mappings table in `lua/config/mappings.lua`.

## Active Plugin Stack

| Category | Plugin |
|---|---|
| Plugin manager | lazy.nvim |
| Completion | blink.cmp + blink-cmp-copilot |
| LSP | nvim-lspconfig (lua_ls, pyright, clangd) + Mason |
| Formatter | conform.nvim (stylua for Lua) |
| Fuzzy finder | Telescope |
| Syntax | Treesitter |
| File explorer | NvimTree (toggle), Oil (float) |
| Buffers | Bufferline (`<Tab>`/`<S-Tab>`) |
| Git | Gitsigns, LazyGit (`<leader>lg`) |
| Debugging | nvim-dap + nvim-dap-ui |
| File marks | Harpoon |
| Terminal | ToggleTerm (`<leader>th`/`<leader>tf`) |
| AI assistant | Avante (Copilot provider) + Copilot.vim |
| Notes | Obsidian.nvim |
