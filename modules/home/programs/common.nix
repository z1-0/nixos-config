{ pkgs, ... }:
{
  imports = [
    ./vscode.nix
    ./browser
  ];
  home.packages = with pkgs; [
    qq
    wechat
    obs-studio
    telegram-desktop
    dbeaver-bin
    meld
    localsend
  ];
}
