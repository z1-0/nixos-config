{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    adw-gtk3
    libnotify
    loupe # Image Viewer
    nautilus # File Manager
    papers # Document Viewer
    showtime # Video Player
  ];
}
