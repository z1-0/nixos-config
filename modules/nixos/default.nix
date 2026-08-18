{
  programs = {
    nix-ld.enable = true;

    appimage = {
      binfmt = true;
      enable = true;
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
