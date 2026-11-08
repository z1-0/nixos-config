{ inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  home.packages = with pkgs; [
    # brave
    inputs.magpie.packages.${system}.default
    telegram-desktop
    wechat
    libreoffice
  ];
}
