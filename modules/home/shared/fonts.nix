{ pkgs, ... }: {
  home.packages = with pkgs; [
    liberation_ttf
    lxgw-wenkai-screen
    maple-mono.Normal-NF-CN
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "slight";
    subpixelRendering = "rgb";
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "Maple Mono Normal NF CN"
        "Noto Sans Mono CJK SC"
      ];
      sansSerif = [
        "LXGW WenKai Screen"
        "Noto Sans CJK SC"
      ];
      serif = [
        "LXGW WenKai Screen"
        "Noto Serif CJK SC"
      ];
    };
  };
}
