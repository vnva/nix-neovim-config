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
          neovimToolPackages = with pkgs; [
            ripgrep
            fd
            git
            wl-clipboard
            lua-language-server
            stylua
            nixd
            nixfmt
          ];
          neovimPackage = pkgs.symlinkJoin {
            name = "neovim-config";
            paths = [ pkgs.neovim ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram "$out/bin/nvim" \
                --prefix PATH : ${pkgs.lib.makeBinPath neovimToolPackages} \
                --add-flags "-u ${self}/src/init.lua"
            '';
          };
          neovimTools = pkgs.buildEnv {
            name = "neovim-tools";
            paths = neovimToolPackages;
          };
        in
        {
          neovim = neovimPackage;
          neovim-tools = neovimTools;
          default = neovimPackage;
        }
      );
    };
}
