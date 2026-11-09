{
  inputs,
  lib,
  config,
  ...
}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = lib.attrValues inputs.self.overlays;
  };

  nix = {
    extraOptions = ''
      !include ${config.age.secrets."nix-access-tokens".path}
    '';

    settings = {
      accept-flake-config = true;
      commit-lock-file-summary = "chore: update flake.lock";
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
