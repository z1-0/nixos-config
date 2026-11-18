{ inputs, lib, ... }:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
in
{
  home-manager.users.${username}.programs.noctalia = {
    enable = true;
    settings = lib.importTOML ./config.toml;
  };

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };
}
