{ flake, ... }:
{
  imports = [
    flake.inputs.nix-index-database.homeModules.default
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
