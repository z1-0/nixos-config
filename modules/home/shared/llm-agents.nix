{ pkgs, flake, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  cc-switch = flake.inputs.cc-switch.packages.${system}.default;
  cc-switch-fixed = cc-switch.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.wrapGAppsHook4 ];
  });
in
{
  imports = [ flake.self.lib.modules.claude-code-router ];

  services.claude-code-router.enable = true;
  services.claude-code-router.package = pkgs.llm-agents.claude-code-router;

  home = {
    packages = with pkgs; [
      llm-agents.claude-code
      llm-agents.codex
      llm-agents.gemini-cli
      llm-agents.opencode
      cc-switch-fixed
      bubblewrap
      playwright-driver.browsers
    ];

    shellAliases."c" = "claude";

    sessionVariables = {
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
    };
  };
}
