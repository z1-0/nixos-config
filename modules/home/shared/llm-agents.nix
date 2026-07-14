{
  pkgs,
  flake,
  osConfig,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  llm-agents = flake.inputs.llm-agents.packages.${system};
in
{
  home = {
    packages =
      with llm-agents;
      with pkgs;
      [
        antigravity-cli
        bubblewrap
        cc-switch-cli
        claude-code
        ctx7
        flake.self.packages.${system}.tavily-cli
        opencode
        playwright-driver.browsers
        skills
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
