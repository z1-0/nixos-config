{ inputs, pkgs, ... }:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
in
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
      ];
    };
  };

  environment.sessionVariables.QT_IM_MODULES = "wayland;fcitx";

  home-manager.users.${username}.gtk = {
    enable = true;
    gtk2.extraConfig = ''
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig."gtk-im-module" = "fcitx";
    gtk4.extraConfig."gtk-im-module" = "fcitx";
  };
}
