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

  inherit (prev.lixPackageSets.latest)
    colmena
    nix-eval-jobs
    nix-fast-build
    nixpkgs-review
    ;
}
