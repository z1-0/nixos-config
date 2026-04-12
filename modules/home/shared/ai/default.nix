{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bubblewrap
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

}
