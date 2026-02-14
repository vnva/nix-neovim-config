{
  description = "Reusable Neovim configuration for NixOS/Home Manager";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          neovimTools = pkgs.buildEnv {
            name = "neovim-tools";
            paths = with pkgs; [
              ripgrep
              fd
              git
              wl-clipboard
              lua-language-server
              stylua
              nixd
              nixfmt-rfc-style
            ];
          };
        in
        {
          neovim-tools = neovimTools;
          default = neovimTools;
        }
      );

      nixosModules.default = import ./modules/nixos.nix;
      homeManagerModules.default = import ./modules/home-manager.nix;
    };
}
