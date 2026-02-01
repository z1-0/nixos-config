{ flake, ... }:
let
  inherit (flake) inputs;
in
final: prev: {
  # nixpkgs-stable = import inputs.nixpkgs-stable { inherit (prev) system config; };

  nur = import inputs.nur {
    nurpkgs = prev;
    pkgs = prev;
  };

  vscode-extensions = inputs.vscode-extensions.overlays.default final prev;
}
