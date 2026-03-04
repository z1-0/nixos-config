{ flake, pkgs, ... }:
let
  antigravityPkg = flake.inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = with pkgs; [
    opencode
    gemini-cli
    antigravityPkg
  ];
}
