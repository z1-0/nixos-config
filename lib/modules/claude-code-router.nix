{ _ }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  name = "claude-code-router";
  coreName = "claude-code";

  inherit (lib)
    mkIf
    mkMerge
    mkEnableOption
    mkPackageOption
    optionals
    ;
in
{
  options.programs.${name} = {
    enable = mkEnableOption name;
    package = mkPackageOption pkgs.llm-agents name { };
    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };
    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };
    service.enable = mkEnableOption "the 'Claude Code Router' user service";

    claude-code = {
      enable = mkEnableOption coreName;
      package = mkPackageOption pkgs.llm-agents coreName { };
    };
  };

  config =
    let
      cfg = config.programs.${name};
      coreCfg = cfg.${coreName};
    in
    mkIf cfg.enable (mkMerge [

      {
        home.packages =
          optionals coreCfg.enable [
            coreCfg.package
          ]
          ++ [
            cfg.package
          ];
      }

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

      (mkIf (cfg.service.enable && pkgs.stdenv.isLinux) {
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

      (mkIf (cfg.service.enable && pkgs.stdenv.isDarwin) {
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
