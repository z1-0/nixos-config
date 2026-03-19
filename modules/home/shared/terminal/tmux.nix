{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    clock24 = true;
    mouse = true;
    newSession = true;
    secureSocket = false;
    baseIndex = 1;
    shortcut = "a";

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      yank
    ];
  };
}
