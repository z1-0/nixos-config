{
  pkgs,
  config,
  lib,
  ...
}:
let
  qtctSettings = {
    Appearance = {
      custom_palette = true;
      style = lib.mkIf (config.qt.style ? name) config.qt.style.name;
      icon_theme = config.lib.theme.name;
    };
  };
  kvantumThemeName = "rose-pine-dawn-iris";
  kvantumPackage = pkgs.rose-pine-kvantum;
  kvantumThemeSource = "${kvantumPackage}/share/Kvantum/themes/${kvantumThemeName}";
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
    qt5ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") qtctSettings;
    qt6ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") qtctSettings;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };

  xdg.configFile = lib.mkIf (config.qt.style.name == "kvantum") {
    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = kvantumThemeName;
    };
    "Kvantum/${kvantumThemeName}".source = kvantumThemeSource;
  };
}
