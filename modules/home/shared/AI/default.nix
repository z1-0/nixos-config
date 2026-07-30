{
  pkgs,
  flake,
  osConfig,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) system;
in

{
  imports = [
    flake.inputs.skills.homeModules.default
    flake.self.lib.modules.prompts
  ];

  prompts.source = ./AGENTS.md;

  skills = {
    enable = true;
    enableAgentSymlinks = true;
    install = [
      "blader/humanizer"
      "cocoon-ai/architecture-diagram-generator"
      "dietrichgebert/ponytail"
      "forrestchang/andrej-karpathy-skills"
      "hardikpandya/stop-slop"
      "imbad0202/academic-research-skills"
      "jeffallan/claude-skills"
      "juliusbrussee/caveman"
      "leonxlnx/taste-skill"
      "mattpocock/skills"
      "mvanhorn/last30days-skill"
      "orchestra-research/ai-research-skills"
      "tavily-ai/skills"
      "upstash/context7"
      "vercel-labs/skills"
      "github/awesome-copilot@create-readme"
    ];
  };

  home = {
    packages = with pkgs; [
      antigravity-cli
      bubblewrap
      cc-switch
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
