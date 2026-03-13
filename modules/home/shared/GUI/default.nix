{ pkgs, ... }:
{
  home.packages = with pkgs; [
    google-chrome
    wechat
    telegram-desktop
  ];
}
