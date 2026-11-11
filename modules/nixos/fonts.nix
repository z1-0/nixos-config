{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      lxgw-wenkai-screen
      maple-mono.Normal-NF-CN
    ];
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel.rgba = "rgb";

      defaultFonts = {
        monospace = [ "Maple Mono Normal NF CN" ];
        sansSerif = [ "LXGW WenKai Screen" ];
        serif = [ "LXGW WenKai Screen" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
