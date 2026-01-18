{
  flake,
  lib,
  pkgs,
  ...
}:
{
  time.timeZone = "Asia/Shanghai";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = lib.versions.majorMinor lib.version;

  networking = {
    dhcpcd.enable = false;
    nameservers = [
      "223.5.5.5"
      "119.29.29.29"
    ];
    networkmanager = {
      enable = true;
      dns = "none";
    };
    firewall = {
      enable = true;
      checkReversePath = false;
    };
  };

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
  };

  fonts = {
    packages = with pkgs; [
      maple-mono.Normal-NF-CN
      lxgw-wenkai-screen
      font-awesome
    ];
    fontDir.enable = true;
    fontconfig.enable = true;
  };

  users = {
    users.${flake.config.me.username} = {
      isNormalUser = true;
      extraGroups = [
        "audio"
        "kvm"
        "libvirtd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };
    groups = {
      netdev = { };
      power = { };
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    doas = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  services = {
    blueman.enable = true;
    devmon.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    thermald.enable = true;
    udisks2.enable = true;
    upower.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  boot = {
    kernelModules = [ "kvm-intel" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      systemd = {
        enable = true;
        network.wait-online.enable = false;
      };
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
      powerOnBoot = false;
    };
  };
}
