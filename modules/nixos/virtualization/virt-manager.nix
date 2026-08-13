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
    shellAliases.win = "virt-viewer -c qemu:///system -f -w win & virsh -c qemu:///system start win";

    systemPackages = [
      pkgs.dnsmasq # exec 'virsh net-autostart default'
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
