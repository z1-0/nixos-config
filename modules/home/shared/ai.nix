{ flake, ... }:
{
  imports = [ flake.self.lib.modules.claude-code-router ];

  home.shellAliases."c" = "claude";

  programs.claude-code = {
    enable = true;
    settings = {
      attribution = {
        commit = "";
        pr = "";
      };
      defaultMode = "acceptEdits";
      env = {
        CLAUDE_CODE_IDE_SKIP_AUTO_INSTALL = "1";
        DISABLE_INSTALLATION_CHECKS = "1";
        DISABLE_AUTOUPDATER = "1";
        DISABLE_TELEMETRY = "1";
      };
      language = "chinese";
      permissions = {
        allow = [
          "Bash(git:*)"
          "Bash(gh run:*)"
        ];
        ask = [
          "Bash(git push:*)"
        ];
        deny = [
          "Read(/run/agenix/**)"
        ];
      };

    };
  };

  services.claude-code-router.enable = true;
}
