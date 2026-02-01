{ inputs, root, ... }@flake:
{
  flake.hive = inputs.haumea.lib.load {
    src = root + /hive;
    inputs = { inherit flake; };
  };
}
