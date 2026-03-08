{ flake, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  llm-agents = flake.inputs.llm-agents.packages.${system};
  pkgs-antigravity = flake.inputs.antigravity-nix.packages.${system}.default;
in
{
  home.packages = [
    llm-agents.codex
    llm-agents.opencode
    pkgs.gemini-cli
    pkgs-antigravity
  ];
}
