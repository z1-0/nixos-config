{ lib, ... }:
{
  imports = [
    ./commands
    ./misc
    ./programs/common.nix
    ./shell
    ./theme
  ];

  home = {
    stateVersion = lib.versions.majorMinor lib.version;
    enableNixpkgsReleaseCheck = false;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
