{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  xdg.configFile."starship.toml".source = ./jetpack.toml;
}
