{ pkgs, ... }:
{
  home.packages = with pkgs; [
    opencode
    gemini-cli
    antigravity
  ];
}
