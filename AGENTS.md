# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix`: main flake outputs. Exposes packages (`neovim`, `neovim-tools`) per system.
- `justfile`: local developer workflows (`build`, `run`, `nvim`, `nvim-clean`).
- `stylua.toml`: Lua formatting rules.
- `src/init.lua`: Neovim entrypoint.
- `src/lua/core/`: core runtime config (`options.lua`, `keymaps.lua`, `lazy.lua`, `plugins.lua`).
- `src/lua/plugins/`: plugin specs/config (`lsp.lua`, `format.lua`, `cmp.lua`, `telescope.lua`, `treesitter.lua`, `ui.lua`).
- `modules/`: NixOS/Home Manager module files are present but currently not exported by `flake.nix`.

## Build, Test, and Development Commands
- `just build`: build tool dependencies (`.#neovim-tools`).
- `just run` or `just nvim`: build, then start Neovim with this config.
- `just nvim-clean`: same run in isolated `XDG_*` directories (debugging only).
- `nix run .#neovim`: run wrapped Neovim package directly.
- `nix flake show`: verify exported outputs before opening a PR.

## Coding Style & Naming Conventions
- Lua style is enforced by `stylua` (`stylua.toml`): 2 spaces, single quotes where possible, 100-char line width.
- Keep files focused: core behavior in `src/lua/core/*`, feature/plugin logic in `src/lua/plugins/*`.
- Use lowercase snake_case file names (e.g., `format.lua`, `treesitter.lua`).
- Prefer small, explicit plugin specs over monolithic plugin config files.

## Testing Guidelines
- There is no formal test suite yet.
- Validate changes with:
  - `just build`
  - `just nvim`
  - in Neovim: `:Lazy sync`, `:LspInfo`, and relevant feature checks (`<leader>ff`, `<leader>fg`, `:Format`).
- For LSP/completion changes, verify both `flake.nix` and `*.nix`/`*.lua` buffers.

## Commit & Pull Request Guidelines
- Follow Conventional Commits, as used in history: `fix: ...`, `refactor: ...`, `chore: ...`.
- Keep commits scoped to one concern (e.g., `fix: nixd root_dir fallback`).
- PRs should include:
  - short summary of behavior change,
  - commands used for validation,
  - screenshots/GIFs for UI changes (completion menus, statusline, noice popups).

## Configuration & Security Notes
- Avoid hardcoding machine-specific paths except standard XDG/Nix paths.
- Prefer package-scoped runtime tools via flake outputs over global system assumptions.
