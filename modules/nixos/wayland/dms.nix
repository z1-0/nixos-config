{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [ inputs.dms-plugin-registry.modules.default ];

  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${system}.default;
    quickshell.package = inputs.quickshell.packages.${system}.quickshell;

    systemd.enable = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
    enableDynamicTheming = true;
    enableSystemMonitoring = true;
    enableVPN = true;

    plugins = {
      dankBatteryAlerts.enable = true;
      # dockerManager.enable = true;
    };
  };

  programs.dsearch.enable = true;

  services.upower.enable = true;

  environment.variables = {
    DMS_HIDE_TRAYIDS = "fcitx";
  };
}
