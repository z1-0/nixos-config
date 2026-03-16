{ pkgs, flake, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  home.packages = with pkgs; [
    flake.inputs.antigravity-nix.packages.${system}.default
    llm-agents.gemini-cli
  ];
}
