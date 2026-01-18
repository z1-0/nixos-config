{ lib, ... }:
let
  inherit (lib)
    pipe
    hasSuffix
    filter
    id
    ;
  inherit (lib.filesystem) listFilesRecursive;
in
{
  flake = {
    lib = {
      load =
        let
          isRootDefault = src: path: baseNameOf path == "default.nix" && dirOf path == src;
          filterRootDefault = src: filter (p: !(isRootDefault src p));
        in
        {
          src,
          ignoreRootDefault ? true,
        }:
        pipe src [
          listFilesRecursive
          (filter (hasSuffix ".nix"))
          (if ignoreRootDefault then filterRootDefault src else id)
        ];
    };
  };
}
