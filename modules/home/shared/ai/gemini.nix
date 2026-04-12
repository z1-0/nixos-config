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
}
