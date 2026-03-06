{ flake, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  pkgs-antigravity = flake.inputs.antigravity-nix.packages.${system}.default;
in
{
  home.packages = with pkgs; [
    opencode
    gemini-cli
    pkgs-antigravity
  ];
}
