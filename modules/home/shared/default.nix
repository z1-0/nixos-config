{ osConfig, ... }:
{

  home = {

    shellAliases = osConfig.environment.shellAliases;

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

}
