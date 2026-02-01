{
  flake,
  lib,
  pkgs,
  ...
}:
{
  system.stateVersion = lib.versions.majorMinor lib.version;

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [
    vim
    wget
    gitMinimal
  ];

  programs.zsh.enable = true;
  users.users.${flake.self.hive.user.username}.shell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
}
