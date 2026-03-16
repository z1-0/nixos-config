{
  flake,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [
    flake.inputs.nix-index-database.homeModules.default
  ];

  home = {
    packages = [
      flake.inputs.ah.packages.${system}.default
    ];
    shellAliases = lib.mkDefault osConfig.environment.shellAliases;
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
