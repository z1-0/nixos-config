{ config, inputs, ... }:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
  home = config.users.users.${username}.home;
in
{
  programs.umbriel.enable = true;

  systemd.user.tmpfiles.users.${username}.rules = [
    "L '${home}/.config/umbriel/config.toml' - - - - ${./umbriel.toml}"
  ];
}
