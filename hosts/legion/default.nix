{ inputs, ... }:
let
  username = inputs.self.lib.rootTree.data.profile.content.name;
in
{
  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$6$lE/xH591Oa8DKNzt$Bj80uYEaCISSnWE80AdG3WxQV3QCxLaGpS4SlAh0yF12YGD32oHYd.o8G8yXArIw8q49MxxTsvsqkX9zZWLrn/";
  };
}
