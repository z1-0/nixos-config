{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = builtins.fromJSON (builtins.readFile ./config.json);
    };
    style = builtins.readFile ./style.css;
  };
}
# ❄️
