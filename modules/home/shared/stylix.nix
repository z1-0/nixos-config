{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.homeModules.default ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
    polarity = "dark";

    overlays.enable = false;

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    opacity = {
      popups = 0.9;
      terminal = 0.85;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "Maple Mono Normal NF CN";
        package = pkgs.maple-mono.Normal-NF-CN;
      };
      sansSerif = {
        name = "LXGW WenKai Screen";
        package = pkgs.lxgw-wenkai-screen;
      };
      serif = {
        name = "LXGW WenKai Screen";
        package = pkgs.lxgw-wenkai-screen;
      };
    };

    targets = {
      firefox = {
        profileNames = [ "default" ];
        firefoxGnomeTheme.enable = true;
      };
      gnome.enable = false;
      neovim.enable = false;
      noctalia.enable = true;
    };
  };
}
