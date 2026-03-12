{
  flake,
  pkgs,
  osConfig,
  ...
}:
{
  home.packages = [ pkgs.meld ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = flake.self.lib.user.name;
      user.email = flake.self.lib.user.email;
      push.autoSetupRemote = true;
      protocol."https".allow = "always";
      init.defaultBranch = "main";
      http.postBuffer = 1048575999;
      core.compression = -1;
      url."https://github.com/".insteadOf = [
        "gh:"
        "github:"
      ];
      diff.tool = "meld";
      difftool.prompt = false;
      merge.tool = "meld";
      mergetool.prompt = false;
    };
    signing = {
      format = "ssh";
      key = flake.self.lib.user.sshPubKey;
      signByDefault = true;
    };
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.sidePanelWidth = 0.2;
      git = {
        useExternalDiffGitConfig = true;
        overrideGpg = true;
      };
    };
  };

  programs.mergiraf.enable = true;
  programs.gh.enable = true;

  programs.zsh.envExtra = ''
    GITHUB_PAT="$(${pkgs.coreutils}/bin/cat ${osConfig.age.secrets."github-token".path})";
    export GH_TOKEN=$GITHUB_PAT
    export GITHUB_PERSONAL_ACCESS_TOKEN=$GITHUB_PAT
  '';
}
