{ pkgs, ... }:
{
  imports = [
    ./fcitx.nix
  ];

  home.packages = with pkgs; [
    pavucontrol
    kdePackages.kdeconnect-kde
    kdePackages.dolphin
  ];

}
