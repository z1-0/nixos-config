{ pkgs, ... }:
{
  programs.btop.settings = {
    color_theme = "Rosé Pine Moon";
  };
  xdg.configFile."btop/themes/Rosé Pine Moon.theme".source = ./rose-pine-moon.theme;
}
