{ flake, pkgs, ... }:
let
  inherit (flake) self inputs;
  inherit (inputs) agenix;
in
{
  imports = [ agenix.nixosModules.default ];

  environment.systemPackages = [ agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  age = {
    identityPaths = [ flake.self.hive.user.sshPrivKey ];
    secrets = {
      "mihomo.yaml".file = self + /secrets/mihomo.yaml.age;

      "nix-access-tokens" = {
        file = self + /secrets/nix-access-tokens.age;
        mode = "644";
      };
    };
  };
}
