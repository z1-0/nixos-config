{
  flake,
  modulesPath,
  ...
}:
let
  inherit (flake) self inputs;
  inherit (inputs) nixos-hardware;
  hostName = "shinelon";
in
{
  imports = [
    { networking.hostName = hostName; }
    (modulesPath + "/installer/scan/not-detected.nix")
    (self + /configurations/nixos/${hostName}/hardware.nix)
    (self + /configurations/nixos/common.nix)
    (nixos-hardware + "/common/cpu/intel/haswell")
    (nixos-hardware + "/common/gpu/nvidia/disable.nix")
    (nixos-hardware + "/common/pc/laptop")
    # (nixos-hardware + "/common/pc/laptop/hdd")
    (nixos-hardware + "/common/pc/ssd")
    self.nixosModules.default
  ];
}
