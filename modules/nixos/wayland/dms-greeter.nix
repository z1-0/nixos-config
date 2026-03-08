{ flake, ... }:
{
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${flake.self.lib.user.name}";
  };
}
