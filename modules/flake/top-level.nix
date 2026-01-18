{ inputs, lib, ... }:
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
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
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = lib.attrValues inputs.self.overlays;
        config.allowUnfree = true;
        config.allowUnfreePredicate = _: true;
      };

      packages.default = self'.packages.activate;
    };
}
