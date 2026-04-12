{
  flake,
  pkgs,
  ...
}:
{
  imports = [ flake.self.lib.modules.claude-code-router ];

  home.packages = [
    pkgs.llm-agents.agent-browser
  ];

  home.shellAliases."c" = "claude";

  services.claude-code-router.enable = true;
  services.claude-code-router.package = pkgs.llm-agents.claude-code-router;

  programs.claude-code = {
    enable = true;
    package = pkgs.llm-agents.claude-code;
    enableMcpIntegration = true;
    settings = {
      language = "chinese";
      attribution = {
        commit = "";
        pr = "";
      };
      env = {
        CLAUDE_CODE_IDE_SKIP_AUTO_INSTALL = "1";
        DISABLE_INSTALLATION_CHECKS = "1";
        DISABLE_AUTOUPDATER = "1";
        DISABLE_TELEMETRY = "1";
      };
      enabledPlugins = {
        "claude-code-setup@claude-plugins-official" = true;
        "claude-md-management@claude-plugins-official" = true;
        "commit-commands@claude-plugins-official" = true;
        "frontend-design@claude-plugins-official" = true;
        "ralph-loop@claude-plugins-official" = true;
        "security-guidance@claude-plugins-official" = true;

        "rust-analyzer-lsp@claude-plugins-official" = true;

        "agent-browser@agent-browser" = true;
        "superpowers@superpowers-dev" = true;
        "voltagent-dev-exp@voltagent-subagents" = true;
      };
      extraKnownMarketplaces = {
        "agent-browser".source = {
          source = "github";
          repo = "vercel-labs/agent-browser";
        };
        "superpowers-dev".source = {
          source = "github";
          repo = "obra/superpowers";
        };
        "voltagent-subagents".source = {
          source = "github";
          repo = "VoltAgent/awesome-claude-code-subagents";
        };
      };
    };
  };

}
