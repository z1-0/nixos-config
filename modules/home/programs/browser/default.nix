{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    # ./zen.nix
  ];
  home.packages = with pkgs; [
    brave
  ];
}
