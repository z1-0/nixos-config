{
  config,
  lib,
  pkgs,
  ...
}:
let
  name = "clash-nyanpasu";
in
{
  options.programs.${name} = {
    enable = lib.mkEnableOption name;
    package = lib.mkPackageOption pkgs name { };
    tunMode = lib.mkEnableOption "Setcap for TUN Mode. DNS settings won't work on this way";
    autoStart = lib.mkEnableOption "Sparkle auto launch";
  };

  config =
    let
      cfg = config.programs.${name};
    in
    lib.mkIf cfg.enable {
      environment.systemPackages = [
        cfg.package
        (lib.mkIf cfg.autoStart (
          pkgs.makeAutostartItem {
            inherit name;
            inherit (cfg) package;
          }
        ))
      ];

      security.wrappers.${name} = lib.mkIf cfg.tunMode {
        owner = "root";
        group = "root";
        capabilities = "cap_net_bind_service,cap_net_raw,cap_net_admin=+ep";
        source = lib.getExe cfg.package;
      };

      networking.firewall.trustedInterfaces = [ "mihomo" ];
    };
}
