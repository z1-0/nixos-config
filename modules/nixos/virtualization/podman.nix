{
  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    containers = {
      enable = true;
      registries.search = [ "docker.io" ];
    };
  };
}
