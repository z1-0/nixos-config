{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./tofi.nix
    ./uwsm
    ./waybar
  ];
  home.packages = with pkgs; [
    wl-clipboard
    brightnessctl
    swaynotificationcenter
  ];
}
