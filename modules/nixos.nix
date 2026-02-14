{ config, lib, pkgs, ... }:
let
  cfg = config.myNeovim;
in
{
  options.myNeovim.enable = lib.mkEnableOption "my Neovim configuration";

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraPackages = with pkgs; [
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

    environment.etc."xdg/nvim".source = ../src;
  };
}
