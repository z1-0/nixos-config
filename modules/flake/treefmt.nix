{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
  perSystem =
    {
      self',
      inputs',
      pkgs,
      system,
      config,
      ...
    }:
    {
      treefmt.config = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          stylua.enable = true;
          prettier.enable = true;
        };
      };
    };
}
