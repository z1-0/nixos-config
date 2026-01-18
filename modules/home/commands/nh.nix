{ config, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 5";
    flake = "${config.home.homeDirectory}/Projects/nix-config";
  };
}
