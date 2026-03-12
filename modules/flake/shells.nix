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

      treefmt.programs = lib.genAttrs self.lib.project.formatters (_: {
        enable = true;
      });

      pre-commit.settings = {
        hooks =
          lib.genAttrs self.lib.project.linters (_: {
            enable = true;
          })
          // {
            statix.settings.config = "${pkgs.writeText "statix.toml" ''disabled = [ "unquoted_uri" ]''}";
          };
        excludes = [
          "^secrets/"
        ];
      };
    };
}
