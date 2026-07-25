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
      ];

      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://z1-0.cachix.org"
      ];

      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "z1-0.cachix.org-1:FS7lPgL0StRBOPrlu0RgdCL7LafUI23+U6Iivdw5QK8="
      ];

      trusted-users = [
        "@wheel"
        "@admin"
      ];
    };
  };
}
