{ config, ... }:
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    configFile = config.age.secrets."mihomo.yaml".path;
  };
}
