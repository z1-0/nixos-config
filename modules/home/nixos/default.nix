{
  flake,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  home.packages = [
    flake.inputs.tdx.packages.${system}.default
  ];
}
