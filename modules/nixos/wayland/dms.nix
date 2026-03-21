{
  flake,
  pkgs,
  lib,
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
      commandRunner.enable = true;
      dankBatteryAlerts.enable = true;
      dankHooks.enable = true;
      dockerManager.enable = true;
      niriWindows.enable = true;
    };
  };

  programs.dsearch.enable = true;

  services.upower.enable = true;

  environment = {
    shellAliases = lib.mkForce {
      copy = "dms clipboard copy";
      paste = "dms clipboard paste";
    };

    variables = {
      DMS_HIDE_TRAYIDS = "fcitx";
    };
  };
}
