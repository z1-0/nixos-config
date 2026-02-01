{ pkgs, ... }:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    opencode
  ];
}
