{
  flake,
  lib,
  config,
  ...
}:
let
  inherit (flake) self inputs;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = lib.attrValues self.overlays;
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    extraOptions = ''
      !include ${config.age.secrets."nix-access-tokens".path}
    '';

    settings = {
      max-jobs = "auto";

      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      substituters = [
        "https://cache.nixos.org/?priority=10"
        "https://cache.garnix.io"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      trusted-users = [
        "@wheel"
        "@admin"
      ];
    };
  };
}
