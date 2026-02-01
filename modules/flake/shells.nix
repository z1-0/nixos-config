{
  inputs,
  self,
  lib,
  ...
}:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        inherit (config.pre-commit) shellHook;

        packages = [
          pkgs.just
          config.treefmt.build.wrapper
        ]
        ++ (lib.attrValues config.treefmt.build.programs)
        ++ config.pre-commit.settings.enabledPackages;
      };

      treefmt.programs = lib.genAttrs self.hive.project.formatters (_: {
        enable = true;
      });

      pre-commit.settings = {
        hooks = lib.genAttrs self.hive.project.linters (_: {
          enable = true;
        });
        excludes = [
          "^secrets/"
        ];
      };
    };
}
