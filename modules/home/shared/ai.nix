{
  config,
  lib,
  pkgs,
  ...
}:
let
  pkgs-ccr = pkgs.llm-agents.claude-code-router;
in
{
  home.packages = [
    pkgs.llm-agents.claude-code
    pkgs-ccr
  ];

  programs.zsh.initContent = lib.mkIf config.programs.zsh.enable ''
    eval "$(${pkgs-ccr}/bin/ccr activate)"
  '';

  systemd.user.services.ccr = {
    Unit = {
      Description = "Claude Code Router";
      After = [ "network.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs-ccr}/bin/ccr start";
      Restart = "on-failure";
    };
  };
}
