{pkgs, ...}: {
  home.packages = with pkgs; [
    wechat
    telegram-desktop
  ];

  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };
}
