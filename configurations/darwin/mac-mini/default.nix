{ flake, ... }:
let
  inherit (flake) self inputs;
  inherit (inputs) nixos-hardware;
in
self.lib.system.mkDarwin {
  hostName = "mac-mini";
  hostPlatform = "aarch64-darwin";
  modules = [
  ];
}
