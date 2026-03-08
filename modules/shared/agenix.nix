{ flake, pkgs, ... }:
let
  inherit (flake) self inputs;
  inherit (pkgs.stdenv.hostPlatform) system;
  pkgs-agenix = inputs.agenix.packages.${system}.default;
in
{
  imports = [ inputs.agenix.nixosModules.default ];

  environment.systemPackages = [ pkgs-agenix ];

  age = {
    identityPaths = [ flake.self.lib.user.sshPrivKey ];
    secrets = {
      "mihomo.yaml".file = self + /secrets/mihomo.yaml.age;

      "nix-access-tokens" = {
        file = self + /secrets/nix-access-tokens.age;
        mode = "644";
      };
    };
  };
}
