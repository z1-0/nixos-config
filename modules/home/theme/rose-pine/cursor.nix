{ config, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor.enable = true;
    package = config.lib.theme.packages.cursor;
    name = config.lib.theme.cursorName;
    size = config.lib.theme.cursorSize;
  };
}
