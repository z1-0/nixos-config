{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) self;
in
{
  programs.virt-manager.enable = true;
  environment = {
    shellAliases.win = "virsh -c qemu:///system start win && virt-viewer -c qemu:///system -f -w win";

    sessionVariables.OSINFO_SYSTEM_DIR = "${pkgs.osinfo-db}/share/osinfo";

    systemPackages = [
      pkgs.dnsmasq # exec 'virsh net-autostart default'
      pkgs.libosinfo
      pkgs.osinfo-db
      pkgs.virt-viewer
    ];
  };

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };
    vmVariant.users.users = {
      root.initialPassword = "root";
      nixos.initialPassword = "nixos";
      ${self.lib.user.name}.initialPassword = "nixos";
    };
  };

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
