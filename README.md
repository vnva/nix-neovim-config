# nix-neovim-config

Reusable Neovim config flake for NixOS and Home Manager.

## Structure

```text
src/
  init.lua
  lua/core/options.lua
  lua/core/keymaps.lua
  lua/core/lazy.lua
  lua/plugins/lsp.lua
  lua/plugins/format.lua
```

## Plugins

Plugin manager: `lazy.nvim`.
LSP/formatter binaries are provided by Nix packages.

- LSP: `neovim/nvim-lspconfig` (`lua_ls` via `lua-language-server` from Nix)
- Formatter: `stevearc/conform.nvim` (`stylua` from Nix)
- Nix LSP/Formatter: `nixd` + `nixfmt`
- UI: `tokyonight` + `lualine` + `nvim-notify`
- Completion: `nvim-cmp` + LSP source + snippets

On first Neovim start, `lazy.nvim` is bootstrapped automatically.

When you enable the module, Neovim gets required tools automatically via `programs.neovim.extraPackages`.
No separate dependency installation is needed.

## Flake packages

This flake exports `packages.<system>.neovim-tools` (also `default`) with:

- `ripgrep`
- `fd`
- `git`
- `wl-clipboard`
- `lua-language-server`
- `stylua`

`neovim-tools` is useful for local testing via `nix shell`/`just`, without installing anything into your system.

## Use in your system flake from GitHub

Add this repository as an input in your system flake:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-config.url = "github:<your-user>/nix-neovim-config";
  };
}
```

Then import and enable the NixOS module:

```nix
{
  outputs = { self, nixpkgs, neovim-config, ... }@inputs: {
    nixosConfigurations.my-host = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        neovim-config.nixosModules.default
        {
          myNeovim.enable = true;
        }
      ];
    };
  };
}
```

## Home Manager usage (optional)

```nix
{
  imports = [ neovim-config.homeManagerModules.default ];
  myNeovim.enable = true;
}
```

## Apply on NixOS

```bash
sudo nixos-rebuild switch --flake .#my-host
```

## Quick test

```bash
nix shell nixpkgs#neovim -c nvim -u ./src/init.lua
```

## Just commands

```bash
just nvim
just nvim-clean
just check-tools
```
