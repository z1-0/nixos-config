{ lib, ... }:
let
  userSubmodule = lib.types.submodule {
    options = {
      username = lib.mkOption {
        type = lib.types.str;
      };
      fullname = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
      sshPrivKey = lib.mkOption {
        type = lib.types.str;
        description = ''
          absolute path for SSH private key
        '';
      };
      sshPubKey = lib.mkOption {
        type = lib.types.str;
        description = ''
          absolute path for SSH public key
        '';
      };
    };
  };
in
{
  imports = [
    ../me.nix
  ];
  options = {
    me = lib.mkOption {
      type = userSubmodule;
    };
  };
}
