{ pkgs, ... }: {
  home.packages = with pkgs; [
    brave
    telegram-desktop
    wechat
    libreoffice
  ];

  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };
}
