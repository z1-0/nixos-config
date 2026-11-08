{ inputs, ... }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = [
    inputs.self.lib.rootTree.data.modules.nixosHardware.content
    inputs.self.lib.rootTree.data.modules.intelHardware.content
    (nixos-hardware + "/common/cpu/intel/haswell")
    (nixos-hardware + "/common/gpu/nvidia/disable.nix")
    (nixos-hardware + "/common/pc/laptop")
    (nixos-hardware + "/common/pc/ssd")
  ];

  boot = {
    kernelParams = [
      "acpi_osi=Linux"
      "preempt=full"
    ];
    initrd.availableKernelModules = [
      "rtsx_pci_sdmmc"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5d02aee0-9134-4429-800a-ba5f505375a9";
      fsType = "ext4";
      options = [
        "noatime"
        "nodiratime"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B61B-A2CC";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/16d50638-5a4a-427e-a5b9-41f1a06affd3"; } ];
}
