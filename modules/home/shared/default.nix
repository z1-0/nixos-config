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
      "$HOME/.local/bin"
    ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
