{ pkgs, lib, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
        fcitx5-rose-pine
      ];
    };
  };
  home.sessionVariables = {
    GTK_IM_MODULE = lib.mkForce "";
    SDL_IM_MODULE = "fcitx";
  };
  gtk = {
    gtk2.extraConfig = "gtk-im-module=fcitx";
    gtk3.extraConfig.gtk-im-module = "fcitx";
    gtk4.extraConfig.gtk-im-module = "fcitx";
  };

  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    Theme=rose-pine-moon
  '';
}
