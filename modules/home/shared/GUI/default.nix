{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wechat
    telegram-desktop
  ];
}
