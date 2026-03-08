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
    self._mkBaseSystem {
      inherit hostName hostPlatform modules;
      osModules = [
        (root + /configurations/nixos/${hostName}/configuration.nix)
        (root + /configurations/shared/nixos.nix)
        (import-tree (root + /modules/nixos))
      ];
      hmModules = [
        (import-tree (root + /modules/home/nixos))
        (import-tree (root + /modules/home/shared))
      ];
    };

  darwin =
    {
      hostName,
      hostPlatform,
      modules,
    }:
    self._mkBaseSystem {
      inherit hostName hostPlatform modules;
      osModules = [
        (import-tree (root + /modules/darwin))
      ];
      hmModules = [
        (import-tree (root + /modules/home/darwin))
        (import-tree (root + /modules/home/shared))
      ];
    };

  _mkBaseSystem =
    {
      hostName,
      hostPlatform,
      modules ? [ ],
      hmModules ? [ ],
      osModules ? [ ],
    }:
    {
      networking = { inherit hostName; };
      nixpkgs = { inherit hostPlatform; };

      imports =
        modules
        ++ osModules
        ++ [
          (import-tree (root + /modules/shared))
          (self._mkHome hmModules)
        ];
    };

  _mkHome = hmModules: {
    home-manager = {
      users.${root.hive.user.name} =
        { osConfig, ... }:
        {
          home.stateVersion = osConfig.system.stateVersion;
        };
      sharedModules = hmModules;
    };
  };
}
