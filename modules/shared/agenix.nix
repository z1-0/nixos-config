{ flake, pkgs, ... }:
let
  inherit (flake) self;
in
{
  imports = [
    flake.inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    flake.inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  age = {
    identityPaths = [ flake.config.me.sshPrivKey ];
    secrets = {
      "mihomo.yaml".file = self + /secrets/mihomo.yaml.age;

      "nix-access-tokens" = {
        file = ../../secrets/nix-access-tokens.age;
        mode = "770";
        owner = flake.config.me.username;
        group = "users";
      };
    };
  };
}
