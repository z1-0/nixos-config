{ inputs, ... }:

final: prev: {
  # nixpkgs-stable = import inputs.nixpkgs-stable { inherit (prev) system config; };

  nur = import inputs.nur {
    nurpkgs = prev;
    pkgs = prev;
  };
}
