{
  pkgs,
  flake,
  osConfig,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  imports = [flake.self.lib.modules.claude-code-router];

  services.claude-code-router.enable = false;
  services.claude-code-router.package = pkgs.llm-agents.claude-code-router;

  home = {
    packages = with pkgs; [
      llm-agents.antigravity-cli
      llm-agents.cc-switch-cli
      llm-agents.claude-code
      llm-agents.opencode
      llm-agents.skills

      ctx7
      flake.self.packages.${system}.tavily-cli

      bubblewrap
      playwright-driver.browsers
    ];

    shellAliases."c" = "claude";

    sessionVariables = {
      CONTEXT7_API_KEY = "$(cat ${osConfig.age.secrets."context7".path})";
      TAVILY_API_KEY = "$(cat ${osConfig.age.secrets."tavily".path})";

      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
    };
  };
}
