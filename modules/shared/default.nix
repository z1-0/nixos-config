{ flake, ... }:
let
  inherit (flake) self;
in
{
  imports = self.lib.load {
    src = ./.;
  };
}
