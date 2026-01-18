{ pkgs, ... }:
{

  home.packages = with pkgs; [
    tofi
  ];

  xdg.configFile."tofi/config".text = ''
    font = "/run/current-system/sw/share/X11/fonts/NotoSansMonoCJK-VF.otf.ttc"
    hint-font = false
    ascii-input = false
    matching-algorithm = fuzzy
    fuzzy-match = true
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 5
    background-color = #000A
    selection-color = #eb6f92
  '';
}
