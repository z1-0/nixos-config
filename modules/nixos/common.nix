{ inputs, pkgs, ... }:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
in
{
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          qt6Packages.fcitx5-chinese-addons
          fcitx5-gtk
        ];
      };
    };
  };

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

  users.users.${username}.extraGroups = [
    "wheel"
    "audio"
    "video"
    "kvm"
    "networkmanager"
  ];

  services = {
    envfs.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
  };
}
