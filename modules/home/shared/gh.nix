{ pkgs, osConfig, ... }:
{
  programs.gh.enable = true;

  programs.zsh.envExtra = ''
    export GH_TOKEN="$(${pkgs.coreutils}/bin/cat ${osConfig.age.secrets."gh-token".path})"
  '';
}
