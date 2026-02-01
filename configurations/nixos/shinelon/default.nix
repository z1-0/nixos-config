{ flake, ... }:
let
  inherit (flake) self inputs;
  inherit (inputs) nixos-hardware;
in
self.hive.lib.mkSystem.nixos {
  hostName = "shinelon";
  hostPlatform = "x86_64-linux";

  modules = [
    (nixos-hardware + "/common/cpu/intel/haswell")
    (nixos-hardware + "/common/gpu/nvidia/disable.nix")
    (nixos-hardware + "/common/pc/laptop")
    (nixos-hardware + "/common/pc/laptop/hdd")
    (nixos-hardware + "/common/pc/ssd")
  ];
}
