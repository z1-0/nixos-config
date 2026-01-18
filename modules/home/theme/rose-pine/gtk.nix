{ config, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = config.lib.theme.packages.gtk;
      inherit (config.lib.theme) name;
    };
    iconTheme = {
      package = config.lib.theme.packages.icon;
      inherit (config.lib.theme) name;
    };
    cursorTheme = {
      package = config.lib.theme.packages.cursor;
      name = config.lib.theme.cursorName;
    };
    font = {
      name = config.lib.theme.fontName;
      size = config.lib.theme.fontSize;
    };
  };
}
