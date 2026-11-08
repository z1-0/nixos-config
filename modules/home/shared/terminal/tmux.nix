{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    secureSocket = false;
    sensibleOnTop = true;
    shortcut = "a";

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      yank
    ];
  };
}
