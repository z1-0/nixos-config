{ flake, ... }:
let
  inherit (flake) config self;
in
{
  imports = [
    {
      home-manager = {
        users.${config.me.username} = { };
        sharedModules = [
          self.homeModules.default
          self.homeModules.darwin-only
        ];
      };
    }
    ../options
    ../shared
  ]
  ++ self.lib.load {
    src = ./.;
  };
}
