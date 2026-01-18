{
  flake,
  modulesPath,
  ...
}:
let
  inherit (flake) self inputs;
  inherit (inputs) nixos-hardware;
  hostName = "legion";
in
{
  imports = [
    { networking.hostName = hostName; }
    (modulesPath + "/installer/scan/not-detected.nix")
    (self + /configurations/nixos/${hostName}/hardware.nix)
    (self + /configurations/nixos/common.nix)
    (nixos-hardware + "/common/cpu/intel/tiger-lake")
    (nixos-hardware + "/common/gpu/nvidia/prime.nix")
    (nixos-hardware + "/common/gpu/nvidia/ampere")
    (nixos-hardware + "/common/pc/laptop")
    (nixos-hardware + "/common/pc/ssd")
    self.nixosModules.default
  ];

}
