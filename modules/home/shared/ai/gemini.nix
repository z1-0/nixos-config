{ pkgs, ... }:
{
  programs.gemini-cli = {
    enable = true;
    package = pkgs.llm-agents.gemini-cli;
    enableMcpIntegration = true;
    settings = {
      general = {
        enableAutoUpdate = false;
        enableAutoUpdateNotification = false;
        enableNotifications = true;
      };
      security.auth.selectedType = "oauth-personal";
      privacy.usageStatisticsEnabled = false;
    };
  };

  # gemini extensions install https://github.com/jnMetaCode/superpowers-zh
  # gemini extensions install https://github.com/JuliusBrussee/caveman
  # gemini extensions install https://github.com/gemini-cli-extensions/security
  # gemini extensions install https://github.com/gemini-cli-extensions/code-review
  # gemini extensions install https://github.com/wbh604/UZI-Skill
}
