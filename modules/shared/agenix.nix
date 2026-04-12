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

      "github-token" = {
        file = self + /secrets/github-token.age;
        mode = "644";
      };
      "nix-access-tokens" = {
        file = self + /secrets/nix-access-tokens.age;
        mode = "644";
      };

      "context7-api-key" = {
        file = self + /secrets/context7-api-key.age;
        mode = "644";
      };
      "tavily-api-key" = {
        file = self + /secrets/tavily-api-key.age;
        mode = "644";
      };
    };
  };
}
