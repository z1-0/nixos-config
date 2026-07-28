{
  virtualisation = {
    containers.enable = true;
    containers.registries.settings = {
      "unqualified-search-registries" = [ "docker.io" ];
      registry = [
        {
          location = "docker.io";
          insecure = false;
          blocked = false;
        }
      ];
    };
    podman = {
      enable = true;
      dockerCompat = true;
      # dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
