{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bubblewrap
    playwright-driver.browsers
  ];

  programs.codex = {
    enable = true;
    package = pkgs.llm-agents.codex;
    # enableMcpIntegration = true;
    # settings = {
    # analytics.enabled = false;
    # model = "openai/gpt-oss-120b";
    # model_provider = "nvidia";
    # model_providers = {
    #   nvidia = {
    #     name = "nvidia";
    #     baseURL = "https://integrate.api.nvidia.com/v1";
    #     envKey = "NVIDIA_API_KEY";
    #   };
    # };
    # };
  };

  programs.opencode = {
    enable = true;
    package = pkgs.llm-agents.opencode;
  };

  programs.zsh.envExtra = ''
    export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
    export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
  '';

}
