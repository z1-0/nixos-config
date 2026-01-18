{ flake, pkgs, ... }:
let
  inherit (flake) self;
in
{
  lib = {
    theme = {
      name = "rose-pine-moon";
      fontName = "LXGW WenKai Screen";
      fontSize = 12;
      cursorName = "BreezeX-RosePine-Linux";
      cursorSize = 24;
      packages = {
        gtk = pkgs.rose-pine-gtk-theme;
        icon = pkgs.rose-pine-icon-theme;
        cursor = pkgs.rose-pine-cursor;
      };
    };
  };

  imports = self.lib.load {
    src = ./.;
  };
}
