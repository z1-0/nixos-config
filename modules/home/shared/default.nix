{
  flake,
  osConfig,
  lib,
  ...
}:
{
  imports = [
    flake.inputs.nix-index-database.homeModules.default
  ];

  home.shellAliases = lib.mkDefault osConfig.environment.shellAliases;
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
