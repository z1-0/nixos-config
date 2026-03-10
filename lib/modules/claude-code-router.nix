{ _ }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  name = "claude-code-router";

  inherit (lib)
    mkIf
    mkMerge
    mkEnableOption
    mkPackageOption
    ;
in
{
  options.services.${name} = {
    enable = mkEnableOption name;
    package = mkPackageOption pkgs name { };
    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };
    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };
  };

  config =
    let
      cfg = config.services.${name};
    in
    mkIf cfg.enable (mkMerge [
      { home.packages = [ cfg.package ]; }

      (mkIf cfg.enableBashIntegration {
        programs.bash.initExtra = ''
          eval "$(${cfg.package}/bin/ccr activate)"
        '';
      })

      (mkIf cfg.enableZshIntegration {
        programs.zsh.initContent = ''
          eval "$(${cfg.package}/bin/ccr activate)"
        '';
      })

      (mkIf pkgs.stdenv.isLinux {
        systemd.user.services.${name} = {
          Unit = {
            Description = "Claude Code Router";
            After = [ "network-online.target" ];
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
          Service = {
            Type = "simple";
            ExecStart = "${cfg.package}/bin/ccr start";
            Restart = "on-failure";
            RestartSec = 5;
          };
        };
      })

      (mkIf pkgs.stdenv.isDarwin {
        launchd.agents.${name} = {
          enable = true;
          config = {
            ProgramArguments = [
              "${cfg.package}/bin/ccr"
              "start"
            ];
            KeepAlive = true;
            RunAtLoad = true;
            ThrottleInterval = 5;
          };
        };
      })
    ]);
}
