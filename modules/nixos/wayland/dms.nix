{
  flake,
  lib,
  ...
}:
let
  inherit (flake) inputs;
in
{
  imports = [ inputs.dms-plugin-registry.nixosModules.default ];

  programs.dms-shell = {
    enable = true;

    systemd.enable = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
    enableDynamicTheming = true;
    enableSystemMonitoring = true;
    enableVPN = true;

    plugins = {
      commandRunner.enable = true;
      # dankBatteryAlerts.enable = true;
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
