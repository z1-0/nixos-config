{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (flake) inputs self;
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
    package = pkgs.lixPackageSets.stable.lix;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      # nixpkgs-stable.flake = inputs.nixpkgs-stable;
    };

    extraOptions = ''
      !include ${config.age.secrets."nix-access-tokens".path}
    '';

    settings = {
      max-jobs = "auto";

      experimental-features = [
        "nix-command"
        "flakes"
        # "pipe-operators"
      ];

      substituters = [
        "https://cache.nixos.org/?priority=10"
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://cache.numtide.com"
        "https://cachix.cachix.org"
        "https://devenv.cachix.org"
        "https://ghostty.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      trusted-users = [
        flake.config.me.username
        "@wheel"
        "@admin"
      ];
    };
  };
}
