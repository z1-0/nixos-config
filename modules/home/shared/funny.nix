{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fortune
    boxes
    cmatrix
    pipes
  ];
}
