{ flake, ... }:
let
  inherit (flake) self inputs;
  inherit (inputs) nixos-hardware;
in
self.hive.lib.mkSystem.nixos {
  hostName = "legion";
  hostPlatform = "x86_64-linux";

  modules = [
    (nixos-hardware + "/common/cpu/intel/tiger-lake")
    (nixos-hardware + "/common/gpu/nvidia/prime.nix")
    (nixos-hardware + "/common/gpu/nvidia/ampere")
    (nixos-hardware + "/common/pc/laptop")
    (nixos-hardware + "/common/pc/ssd")
  ];
}
