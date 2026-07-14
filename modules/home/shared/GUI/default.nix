{ pkgs, ... }: {
  home.packages = with pkgs; [
    brave
    telegram-desktop
    wechat
  ];

  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };
}
