{
  # xdg.configFile."uwsm/env-hyprland".text = ''
  #   # export AQ_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"
  #   export XCURSOR_SIZE=24
  #   export XCURSOR_THEME="BreezeX-RosePine-Linux"
  # '';

  programs.bash = {
    enable = true;
    initExtra = ''
      if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };

}
