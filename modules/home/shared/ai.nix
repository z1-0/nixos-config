{ flake, config, ... }:
{
  imports = [ flake.self.lib.modules.claude-code-router ];

  services.claude-code-router.enable = true;

  home.shellAliases."c" = "claude";

  programs.claude-code = {
    enable = true;
    settings = {
      defaultMode = "acceptEdits";
      language = "chinese";
      attribution = {
        commit = "";
        pr = "";
      };
      env = {
        CLAUDE_CODE_IDE_SKIP_AUTO_INSTALL = "1";
        DISABLE_INSTALLATION_CHECKS = "1";
        DISABLE_AUTOUPDATER = "1";
        DISABLE_TELEMETRY = "1";
      };
      permissions = {
        allow = [
          "Bash(gh *)"
          "Bash(git *)"
          "WebSearch(*)"
        ];
        ask = [
          "Bash(sudo *)"
          "Bash(* rm -rf *)"
          "Bash(* install *)"
          "Bash(* uninstall *)"

          "Bash(gh * close *)"
          "Bash(gh * create *)"
          "Bash(gh * delete *)"
          "Bash(gh * edit *)"
          "Bash(gh * lock *)"
          "Bash(gh * merge *)"
          "Bash(gh * reopen *)"
          "Bash(gh * unlock *)"
          "Bash(gh api -X DELETE *)"
          "Bash(gh api -X PATCH *)"
          "Bash(gh api -X POST *)"
          "Bash(gh api -X PUT *)"

          "Bash(git clean -f *)"
          "Bash(git merge *)"
          "Bash(git push *)"
          "Bash(git rebase *)"
          "Bash(git reset --hard *)"
          "Bash(git restore -- *)"
          "Bash(git tag -d *)"
        ];
        deny = [
          "Read(/run/agenix/**)"
          "Read(${config.home.homeDirectory}/.zshenv)"
        ];
      };
      enabledPlugins = {
        "claude-code-setup@claude-plugins-official" = true;
        "claude-md-management@claude-plugins-official" = true;
        "commit-commands@claude-plugins-official" = true;
        "context7@claude-plugins-official" = true;
        "feature-dev@claude-plugins-official" = true;
        "github@claude-plugins-official" = true;
        "playwright@claude-plugins-official" = true;
        "pr-review-toolkit@claude-plugins-official" = true;
        "ralph-loop@claude-plugins-official" = true;

        "voltagent-dev-exp@voltagent-subagents" = true;
      };
      extraKnownMarketplaces = {
        "voltagent-subagents".source = {
          source = "github";
          repo = "VoltAgent/awesome-claude-code-subagents";
        };
      };
    };
  };

}
