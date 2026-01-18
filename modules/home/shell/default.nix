{
  config,
  lib,
  ...
}:
{
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./foot.nix
    ./ghostty.nix
    ./starship
    ./tmux.nix
  ];

  programs.bash = {
    enable = true;
    profileExtra =
      let
        inherit (config.programs)
          alacritty
          ghostty
          ;

        binRealpath =
          cfg:
          let
            inherit (cfg) package;
          in
          lib.optionalString cfg.enable "${package}/bin/${package.pname}";

        mkTerminals = cfgs: map binRealpath cfgs;
      in
      ''
        terminals=(
          ${lib.concatStringsSep "\n" (mkTerminals [
            alacritty
            ghostty
          ])}
        )

        export TERMINAL=''$(printf '%s\n' "''${terminals[@]}" | shuf -n1)
      '';
  };
}
