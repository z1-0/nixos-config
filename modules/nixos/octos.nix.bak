{ flake, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [ flake.inputs.octos.nixosModules.default ];

  # environment.systemPackages = [
  #   flake.inputs.octos.packages.${system}.octos-full
  # ];

  programs.octos = {
    enable = true;
    enableAppSkills = true;
    enableAllChannels = true;
    service.enable = true;
    service.authToken = "octos";
  };

}
