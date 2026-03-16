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

      # substituters = [
      #   "https://cache.nixos.org/?priority=10"
      # ];
      #
      # trusted-public-keys = [
      #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # ];

      extra-substituters = [
        "https://cache.garnix.io"
        "https://cache.numtide.com"
        "hyyps://z1-0.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "z1-0.cachix.org-1:mAd5hSyjiIzSLbMFGFaI3Xhb1GhkEm7Q+ITqTO5gxVw="
      ];

      trusted-users = [
        "@wheel"
        "@admin"
      ];
    };
  };
}
