{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    settings = {
      copy-on-select = false;
      mouse-hide-while-typing = true;
      theme = "dankcolors";
      window-decoration = "none";
      app-notifications = "no-clipboard-copy,no-config-reload";
      shell-integration-features = "cursor,no-cursor,sudo,no-sudo,title,no-title,ssh-env,ssh-terminfo";
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };
}
