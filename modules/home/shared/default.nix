{
  flake,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  home = {
    packages = [
      flake.inputs.ah.packages.${system}.default
    ];

    sessionPath = [
      "$HOME/.bun/bin"
      "$HOME/.cache/npm/global/bin"
    ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
