{ pkgs, ... }:
{
  time.timeZone = "Asia/Shanghai";

  environment = {
    localBinInPath = true;
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      curl
      vim
      wget
    ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
