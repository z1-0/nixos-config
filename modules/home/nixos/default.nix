{
  flake,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  home.packages = with pkgs; [
    flake.inputs.tdx.packages.${system}.default
    wl-clipboard
  ];
}
