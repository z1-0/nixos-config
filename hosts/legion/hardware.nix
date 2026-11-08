{ config, inputs, ... }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = [
    inputs.self.lib.rootTree.data.modules.nixosHardware.content
    inputs.self.lib.rootTree.data.modules.intelHardware.content
    (nixos-hardware + "/common/cpu/intel/tiger-lake")
    (nixos-hardware + "/common/gpu/nvidia/ampere")
    (nixos-hardware + "/common/gpu/nvidia/prime.nix")
    (nixos-hardware + "/common/pc/laptop")
    (nixos-hardware + "/common/pc/ssd")
  ];

  boot = {
    kernelParams = [
      "acpi_osi=Linux"
    ];
    initrd.availableKernelModules = [
      "thunderbolt"
      "usb_storage"
    ];
    # extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8727452f-bcc9-4b2e-942a-1056585820f2";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/8727452f-bcc9-4b2e-942a-1056585820f2";
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/8727452f-bcc9-4b2e-942a-1056585820f2";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/7071-D829";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  hardware = {
    nvidia.prime = {
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };

  services.btrfs.autoScrub.enable = true;
}
