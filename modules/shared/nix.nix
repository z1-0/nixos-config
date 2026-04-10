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

      extra-substituters = [
        "https://cache.garnix.io"
        "https://cache.numtide.com"
        "https://z1-0.cachix.org"
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
