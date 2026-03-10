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
          "WebSearch(*)"
          "Bash(git *)"
          "Bash(gh *)"
        ];
        ask = [
          "Bash(git push *)"
          "Bash(git reset --hard *)"
          "Bash(git clean -f *)"
          "Bash(git restore -- *)"
          "Bash(git tag -d *)"
          "Bash(git rebase *)"
          "Bash(git merge *)"

          "Bash(gh * create *)"
          "Bash(gh * edit *)"
          "Bash(gh * close *)"
          "Bash(gh * merge *)"
          "Bash(gh * delete *)"
          "Bash(gh * lock *)"
          "Bash(gh * unlock *)"
          "Bash(gh * reopen *)"
          "Bash(gh api -X POST *)"
          "Bash(gh api -X PUT *)"
          "Bash(gh api -X PATCH *)"
          "Bash(gh api -X DELETE *)"
        ];
        deny = [
          "Read(/run/agenix/**)"
        ];
      };

    };
  };

  services.claude-code-router.enable = true;
}
