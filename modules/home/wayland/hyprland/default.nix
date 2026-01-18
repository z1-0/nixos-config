{
  xdg.configFile."hypr/".source = ./hypr;

  services = {
    hypridle.enable = true;
    hyprpaper.enable = true;
    hyprsunset.enable = true;
  };

  programs.hyprlock.enable = true;
}
