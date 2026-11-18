{ pkgs, ... }:
{
  gtk.enable = true;

  home.sessionVariables.QT_IM_MODULES = "wayland;fcitx";

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
      ];
      waylandFrontend = true;
      settings = {
        globalOptions = {
          "Hotkey/TriggerKeys" = {
            "0" = "Shift_L";
            "1" = "Shift_R";
          };
          "Hotkey/AltTriggerKeys" = { };
          Behavior = {
            ActiveByDefault = false;
          };
        };
        inputMethod = {
          GroupOrder."0" = "默认";
          "Groups/0" = {
            Name = "默认";
            "Default Layout" = "us";
            DefaultIM = "pinyin";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "pinyin";
        };
      };
    };
  };
}
