{ flake, self, ... }:
let
  inherit (flake.inputs) import-tree;
  root = flake.self;
in
{
  nixos =
    {
      hostName,
      hostPlatform,
      modules,
    }:
    {
      networking = { inherit hostName; };
      nixpkgs = { inherit hostPlatform; };

      imports = modules ++ [
        (root + /configurations/nixos/${hostName}/configuration.nix)
        (root + /configurations/shared/nixos.nix)

        (import-tree (root + /modules/nixos))
        (import-tree (root + /modules/shared))

        (self.mkHome [
          (import-tree (root + /modules/home/nixos))
          (import-tree (root + /modules/home/shared))
        ])
      ];
    };

  darwin =
    {
      hostName,
      hostPlatform,
      modules,
    }:
    {
      networking = { inherit hostName; };
      nixpkgs = { inherit hostPlatform; };

      imports = modules ++ [
        (import-tree (root + /modules/darwin))
        (import-tree (root + /modules/shared))

        (self.mkHome [
          (import-tree (root + /modules/home/darwin))
          (import-tree (root + /modules/home/shared))
        ])
      ];
    };

  mkHome = hmModules: {
    home-manager = {
      users.${root.hive.user.username} =
        { osConfig, ... }:
        {
          home.stateVersion = osConfig.system.stateVersion;
        };
      sharedModules = hmModules;
    };
  };
}
