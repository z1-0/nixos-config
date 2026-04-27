{ osConfig, ... }:
{
  programs.mcp = {
    enable = true;
    servers = {
      context7 = {
        url = "https://mcp.context7.com/mcp";
        headers = {
          CONTEXT7_API_KEY = "\${CONTEXT7_API_KEY}";
        };
      };
      github = {
        url = "https://api.githubcopilot.com/mcp";
        headers = {
          Authorization = "Bearer \${GITHUB_PERSONAL_ACCESS_TOKEN}";
        };
      };
      tavily = {
        url = "https://mcp.tavily.com/mcp";
        headers = {
          Authorization = "Bearer \${TAVILY_API_KEY}";
        };
      };
    };
  };

  home.sessionVariables = {
    CONTEXT7_API_KEY = "$(cat ${osConfig.age.secrets."context7-api-key".path})";
    GITHUB_PERSONAL_ACCESS_TOKEN = "$(cat ${osConfig.age.secrets."github-token".path})";
    TAVILY_API_KEY = "$(cat ${osConfig.age.secrets."tavily-api-key".path})";
  };
}
