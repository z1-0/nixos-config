{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus # File Manager
    loupe # Image Viewer
    papers # Document Viewer
    showtime # Video Player
    adw-gtk3
  ];
}
