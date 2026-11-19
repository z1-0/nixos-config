{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.default ];

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
      applications = 1.0;
      desktop = 0.85;
      popups = 0.9;
      terminal = 0.9;
    };

    fonts = {
      sizes = {
        desktop = 12;
        applications = 14;
        terminal = 14;
        popups = 12;
      };

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
      console.enable = true;
      gnome.enable = false;
    };
  };
}
