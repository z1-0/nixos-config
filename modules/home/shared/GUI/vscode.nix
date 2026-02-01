{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions.vscode-marketplace; [
        # golang.go
        jnoortheen.nix-ide
        # ms-python.python
        rust-lang.rust-analyzer
        # sumneko.lua
        yzhang.markdown-all-in-one

        danklinux.dms-theme
        eamodio.gitlens
        esbenp.prettier-vscode
        kamikillerto.vscode-colorize
        mkhl.direnv
        ms-ceintl.vscode-language-pack-zh-hans
        vscode-icons-team.vscode-icons
      ];
      userSettings = {
        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "extensions.ignoreRecommendations" = true;

        "editor.fontSize" = 16;
        "editor.fontFamily" = "'Maple Mono Normal NF CN', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "editor.tabSize" = 2;
        "editor.rulers" = [
          80
          100
        ];
        "editor.insertSpaces" = true;
        "editor.formatOnPaste" = false;
        "editor.formatOnType" = false;
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "modifications";
        "editor.bracketPairColorization.enabled" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";

        "[go]"."editor.defaultFormatter" = "golang.go";
        "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
        "[python]"."editor.defaultFormatter" = "ms-python.python";
        "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "[lua]"."editor.defaultFormatter" = "sumneko.lua";
        "[markdown]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;

        "git.autofetch" = true;
        "git.enableCommitSigning" = true;
        "git.enableSmartCommit" = true;
        "git.openRepositoryInParentFolders" = "always";

        "search.exclude" = {
          "**/.direnv" = true;
          "**/.git" = true;
          "**/node_modules" = true;
          "*.lock" = true;
          "tmp" = true;
        };
      };
    };
  };
}
