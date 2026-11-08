{ inputs, ... }:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
in
{
  users.groups.podman.members = [ username ];

  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    containers = {
      enable = true;
      registries.settings = {
        unqualified-search-registries = [ "docker.io" ];
      };
    };
  };
}
