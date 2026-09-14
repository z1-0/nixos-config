{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [
    20128
    443
  ];

  networking.firewall.allowedUDPPorts = [
    20128
    443
  ];
}
