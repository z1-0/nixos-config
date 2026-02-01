{ flake, ... }:
let
  inherit (flake) self inputs;
  inherit (inputs) nixos-hardware;
in
self.hive.lib.mkSystem.darwin {
  hostName = "mac-mini";
  hostPlatform = "aarch64-darwin";
  modules = [
  ];
}
