{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
in
{
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  home.packages = with pkgs; [
    gcc
    lua51Packages.lua
    lua51Packages.luarocks
    nodejs
    tree-sitter
  ];
}
