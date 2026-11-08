{
  inputs,
  osConfig,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = inputs.self.lib.rootTree.data.profile.content.name;
      user.email = inputs.self.lib.rootTree.data.profile.content.email;
      push.autoSetupRemote = true;
      protocol."https".allow = "always";
      init.defaultBranch = "main";
      http.postBuffer = 1048575999;
      core.compression = -1;
      core.editor = "nvim";
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
      key = inputs.self.lib.rootTree.data.profile.content.sshPubKey;
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

  home.packages = [ pkgs.meld ];

  home.sessionVariables = {
    GH_TOKEN = "$(cat ${osConfig.age.secrets."github-token".path})";
  };
}
