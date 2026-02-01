{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    tree-sitter
    gcc
    nodejs

    # lua
    lua51Packages.lua
    lua51Packages.lua-lsp
    lua51Packages.luarocks
    stylua

    # nix
    nil
    nixd
    nixfmt
    statix
  ];
}
