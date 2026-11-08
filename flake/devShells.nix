{
  inputs,
  self,
  lib,
  ...
}:
{
  debug = true;

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

      treefmt.programs = lib.genAttrs self.lib.rootTree.data.formatters.content (_: {
        enable = true;
      });

      pre-commit.settings = {
        hooks =
          lib.genAttrs self.lib.rootTree.data.linters.content (_: {
            enable = true;
          })
          // {
            statix = {
              enable = true;
              settings.config = "${pkgs.writeText "statix.toml" ''disabled = [ "repeated_keys" ]''}";
            };
          };
        excludes = [
          "^secrets/"
          "^modules/home/shared/AI/AGENTS\\.md$"
        ];
      };
    };
}
