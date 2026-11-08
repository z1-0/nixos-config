{
  inputs,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  home = {
    packages = [
      inputs.ah.packages.${system}.default
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
