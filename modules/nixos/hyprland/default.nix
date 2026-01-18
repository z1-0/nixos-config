{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
in
{
  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    systemd.setPath.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];
    extraConfig = ''
      source=/etc/xdg/hypr/theme.conf

      $execPrefix = uwsm app --

      ${builtins.readFile ./hypr/binds.conf}

      ${builtins.readFile ./hypr/exec.conf}

      ${builtins.readFile ./hypr/general.conf}

      ${builtins.readFile ./hypr/hyprscrolling.conf}

      ${builtins.readFile ./hypr/rules.conf}

      ${builtins.readFile ./hypr/theme.conf}
    '';
  };

  environment.etc."xdg/hypr/theme.conf".source = ./hypr/theme.conf;
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland:
}
