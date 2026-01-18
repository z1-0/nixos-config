{
  programs.fish = {
    shellInit = ''
      fish_config theme choose "Rosé Pine Moon"
    '';
  };
  xdg.configFile."fish/themes/Rosé Pine Moon.theme".source = ./rose-pine-moon.theme;
}
