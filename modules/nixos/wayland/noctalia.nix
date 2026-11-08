{ config, inputs, ... }:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
  home = config.users.users.${username}.home;
in
{
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  # systemd.user.tmpfiles.users.${username}.rules = [
  #   "L '${home}/.config/noctalia/config.toml' - - - - ${./noctalia.toml}"
  # ];
}
