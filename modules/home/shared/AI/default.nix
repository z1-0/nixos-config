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
      "conorbronsdon/avoid-ai-writing"
      "dietrichgebert/ponytail"
      "firecrawl/skills"
      "github/awesome-copilot@create-readme"
      "hardikpandya/stop-slop"
      "imbad0202/academic-research-skills"
      "jeffallan/claude-skills"
      "juliusbrussee/caveman"
      "leonxlnx/taste-skill"
      "lifelonglazylearner/qu-ai-wei"
      "mattpocock/skills"
      "mrgediao/shuorenhua"
      "multica-ai/andrej-karpathy-skills"
      "mvanhorn/last30days-skill"
      "orchestra-research/ai-research-skills"
      "redfox-data/redfox-community"
      "tavily-ai/skills"
      "upstash/context7"
      "vercel-labs/skills"
    ];
  };

  home = {
    packages = with pkgs; [
      bubblewrap
      ctx7
      firecrawl-cli
      flake.self.packages.${system}.tavily-cli
      opencode
      playwright-driver.browsers
      skills
    ];

    shellAliases."oc" = "opencode";

    sessionVariables = {
      CONTEXT7_API_KEY = "$(cat ${osConfig.age.secrets."context7".path})";
      FIRECRAWL_API_KEY = "$(cat ${osConfig.age.secrets."firecrawl".path})";
      TAVILY_API_KEY = "$(cat ${osConfig.age.secrets."tavily".path})";

      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
    };
  };
}
