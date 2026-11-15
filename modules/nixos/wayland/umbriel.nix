{
  config,
  inputs,
  pkgs,
  ...
}:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
  home = config.users.users.${username}.home;

  palette = config.lib.stylix.colors.withHashtag;

  configFile = pkgs.replaceVars ./umbriel.toml {
    inherit (palette)
      base00
      base01
      base03
      base04
      base05
      base09
      base0B
      base0D
      ;
  };
in
{
  programs.umbriel.enable = true;

  systemd.user.tmpfiles.users.${username}.rules = [
    "L+ '${home}/.config/umbriel/config.toml' - - - - ${configFile}"
  ];
}
