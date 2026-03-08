{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    gcc
    nodejs
    prettier
    tree-sitter

    # lua
    lua51Packages.lua
    lua51Packages.lua-lsp
    lua51Packages.luarocks
    stylua

    # nix
    nixd
    nixfmt
    statix
  ];
}
