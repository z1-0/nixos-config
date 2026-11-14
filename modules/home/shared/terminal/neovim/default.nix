{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    sideloadInitLua = true;

    extraLuaPackages =
      luaPkgs: with luaPkgs; [
        lua
        lua-lsp
        luarocks
      ];
  };

  home.packages = with pkgs; [
    gcc
    python3
    tree-sitter

    bun
    nodejs

    nixd
    nixfmt
    statix

    markdownlint-cli2
    prettier
    shfmt
    stylua
    taplo
  ];

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
