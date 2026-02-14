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
          neovimPackage = pkgs.symlinkJoin {
            name = "neovim-config";
            paths = [ pkgs.neovim ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram "$out/bin/nvim" \
                --prefix PATH : ${pkgs.lib.makeBinPath (with pkgs; [
                  ripgrep
                  fd
                  git
                  wl-clipboard
                  lua-language-server
                  stylua
                  nixd
                  nixfmt
                ])} \
                --add-flags "-u ${self}/src/init.lua"
            '';
          };
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
              nixfmt
            ];
          };
        in
        {
          neovim = neovimPackage;
          neovim-tools = neovimTools;
          default = neovimPackage;
        }
      );

      nixosModules.default = import ./modules/nixos.nix;
      homeManagerModules.default = import ./modules/home-manager.nix;
    };
}
