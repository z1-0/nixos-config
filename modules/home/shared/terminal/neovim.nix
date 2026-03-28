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

    bun
    nodejs
    prettier
    tree-sitter

    lua51Packages.lua
    lua51Packages.lua-lsp
    lua51Packages.luarocks
    stylua

    nixd
    nixfmt
    statix
  ];
}
