{ inputs, root, ... }@flake:
{
  flake.lib = inputs.haumea.lib.load {
    src = root + /lib;
    inputs = { inherit flake; };
  };
}
