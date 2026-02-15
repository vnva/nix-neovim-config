# nix-neovim-config

Neovim configuration as a flake package.

## What this repo provides

- `packages.<system>.neovim`
  - wrapped `nvim` that always starts with this config (`src/init.lua`)
  - includes runtime tools in PATH for this Neovim process:
    - `ripgrep`, `fd`, `git`, `wl-clipboard`
    - `lua-language-server`, `stylua`
    - `nixd`, `nixfmt`
- `packages.<system>.neovim-tools`
  - tools-only package (same toolset as above)

Default package is `packages.<system>.neovim`.

## Project structure

```text
src/
  init.lua
  lua/core/
    options.lua
    keymaps.lua
    lazy.lua
    plugins.lua
  lua/plugins/
    lsp.lua
    format.lua
    cmp.lua
    telescope.lua
    treesitter.lua
    ui.lua
flake.nix
justfile
stylua.toml
```

## Features

- LSP
  - `lua_ls` (`lua-language-server`)
  - `nixd`
- Formatting
  - Lua: `stylua`
  - Nix: `nixfmt`
- Completion
  - `nvim-cmp` + LSP + snippets
  - `supermaven-nvim` inline AI suggestions
- Search/navigation
  - Telescope file finder and live grep
- UI
  - transparent editor background with readable popup menus
- Treesitter
  - configured with `nvim-treesitter`

## Keymaps

Leader is `Space`.

- `Space ff` find files (Telescope)
- `Space fg` live grep (Telescope)
- `Space w` save
- `Space q` quit
- `Space h/j/k/l` move between windows

LSP mappings (on attach):

- `gd` definition
- `gr` references
- `K` hover
- `Space rn` rename
- `Space ca` code action

Completion mappings:

- `<C-Space>` trigger completion
- `<CR>` confirm selected item
- `<Tab>` / `<S-Tab>` navigate completion/snippets
- `<C-l>` accept Supermaven suggestion
- `<C-j>` accept next Supermaven word
- `<C-]>` clear Supermaven suggestion

## Local usage

### With just

- `just build` build tool dependencies (`.#neovim-tools`)
- `just run` build + run Neovim with this config
- `just nvim` alias for `just run`
- `just nvim-clean` run with isolated `XDG_*` paths in `/tmp`

### Without just

Run with wrapped package:

```bash
nix run .#neovim
```

Or with tools package + explicit config:

```bash
nix shell .#neovim-tools nixpkgs#neovim -c nvim -u ./src/init.lua
```

## Use in your system flake as a package

Add input:

```nix
inputs.neovim-config.url = "github:<your-user>/nix-neovim-config";
```

Install wrapped Neovim package directly:

```nix
environment.systemPackages = [
  inputs.neovim-config.packages.${pkgs.system}.neovim
];
```

This does not require enabling any module from this repo.

## Notes

- This flake exports packages only.
- First startup requires network access to bootstrap `lazy.nvim` and plugins.

## Troubleshooting

- `nixd is not in PATH`
  - Ensure you run via `nix run .#neovim` or install `packages.<system>.neovim`.
- Treesitter recompiles repeatedly
  - Avoid `nvim-clean` for normal use (it uses temporary `XDG_*` directories).
- Check active LSP clients
  - `:LspInfo`
- Show diagnostics/problems
  - `:lopen` or `:Telescope diagnostics`
