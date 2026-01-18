{ pkgs, ... }:
{
  imports = [
    ./ai
    # ./funny.nix
    ./btop.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./neovim
    ./nh.nix
    ./yazi.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    bat
    bottom
    desktop-file-utils
    dust
    fd
    grex
    imv
    jq
    mpv
    ouch
    poppler
    procs
    ripgrep
    sd
    sshpass
    ueberzugpp
    unar
    unzip
    wget
    xdg-utils
    xh
    zip
  ];

}
