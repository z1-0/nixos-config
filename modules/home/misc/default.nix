{ flake, pkgs, ... }:
{
  imports = [
    ./ssh.nix
  ];
  home.packages = with pkgs; [
    screenshot
    flake.inputs.ah.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
