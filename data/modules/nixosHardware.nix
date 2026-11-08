{ inputs, ... }:
{
  imports = [
    (inputs.nixpkgs + "/nixos/modules/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.systemd.network.wait-online.enable = false;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 6;
      efi.canTouchEfiVariables = true;
    };
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };
  };

  hardware = {
    enableAllHardware = true;
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
