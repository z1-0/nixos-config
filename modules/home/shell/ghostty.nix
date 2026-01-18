{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
in
{
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # clearDefaultKeybinds = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
