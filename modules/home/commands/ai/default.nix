{
  flake,
  pkgs,
  ...
}:
{
  home.packages = with flake.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    # gemini-cli
    opencode
  ];
}
