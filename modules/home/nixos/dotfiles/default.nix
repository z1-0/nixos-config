{ lib, ... }:
{
  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };

  home.activation.mkDmsGenConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/niri/dms
    touch ~/.config/niri/dms/{alttab,binds,colors,cursor,layout,outputs,windowrules,wpblur}.kdl

    mkdir -p ~/.config/ghostty/themes
    touch /home/zion/.config/ghostty/themes/dankcolors
  '';
}
