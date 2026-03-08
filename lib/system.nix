{ flake, self, ... }:
let
  inherit (flake.inputs) import-tree;
  root = flake.self;
in
{
  mkNixos =
    {
      hostName,
      hostPlatform,
      modules,
    }:
    self.mkBaseSystem {
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

  mkDarwin =
    {
      hostName,
      hostPlatform,
      modules,
    }:
    self.mkBaseSystem {
      inherit hostName hostPlatform modules;
      osModules = [
        (root + /configurations/darwin/${hostName}/configuration.nix)
        (root + /configurations/shared/darwin.nix)
        (import-tree (root + /modules/darwin))
      ];
      hmModules = [
        (import-tree (root + /modules/home/darwin))
        (import-tree (root + /modules/home/shared))
      ];
    };

  mkBaseSystem =
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
          (self.mkHome hmModules)
        ];
    };

  mkHome = hmModules: {
    home-manager = {
      users.${root.lib.user.name} =
        { osConfig, ... }:
        {
          home.stateVersion = osConfig.system.stateVersion;
        };
      sharedModules = hmModules;
    };
  };
}
