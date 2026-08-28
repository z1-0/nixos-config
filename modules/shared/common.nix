{
  flake,
  lib,
  pkgs,
  ...
}:
{
  system.stateVersion = lib.versions.majorMinor lib.version;

  time.timeZone = "Asia/Shanghai";

  environment = {
    localBinInPath = true;
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      vim
      wget
      gitMinimal
    ];
  };

  programs.zsh.enable = true;
  users.users.${flake.self.lib.user.name}.shell = pkgs.zsh;
}
