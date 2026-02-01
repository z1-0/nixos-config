{ flake, pkgs, ... }:
let
  inherit (flake) self;
in
{
  programs.virt-manager.enable = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };
    vmVariant = {
      users.users = {
        root.initialPassword = "root";
        nixos.initialPassword = "nixos";
        ${self.hive.user.username}.initialPassword = "nixos";
      };
    };
  };

  # exec 'virsh net-autostart default'
  environment.systemPackages = [ pkgs.dnsmasq ];
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
