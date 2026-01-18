{ flake, ... }:
let
  inherit (flake) config;
in
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "${config.me.username}" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
