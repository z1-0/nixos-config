{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    nerdfetch
    fastfetch
    cmatrix
    cowsay
    fortune
    lolcat
  ];
}
