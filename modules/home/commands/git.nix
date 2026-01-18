{ flake, ... }:
let
  difftOptions = {
    color = "always";
    display = "side-by-side"; # “side-by-side”, “side-by-side-show-both”, “inline”
  };
in
{
  programs.git = {
    enable = true;
    lfs.enable = false;
    settings = {
      user.email = flake.config.me.email;
      user.name = flake.config.me.username;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.compression = -1;
      http.postBuffer = 1048575999;
      protocol."https".allow = "always";
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
      key = flake.config.me.sshPubKey;
      signByDefault = true;
    };
    ignores = [ ".devenv" ];

  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
    options = {
      inherit (difftOptions) color display;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.sidePanelWidth = 0.2;
      git.pagers = [
        {
          externalDiffCommand = "difft --color=${difftOptions.color} --display=${difftOptions.display}";
        }
      ];
    };
  };

  programs.mergiraf.enable = true;

}
