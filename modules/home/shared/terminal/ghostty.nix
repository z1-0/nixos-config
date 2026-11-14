{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;

    settings = {
      app-notifications = "no-clipboard-copy,no-config-reload";

      # Work around Ghostty(GTK) clipboard getting stuck under wlroots:
      # rejected OSC 52 writes leave GTK thinking it owns the clipboard.
      # Local copy still works; remote OSC 52 over ssh/tmux is disabled.
      # Upstream: https://github.com/ghostty-org/ghostty/discussions/13903
      clipboard-write = "deny";

      copy-on-select = "none";

      keybind = [
        "performable:ctrl+shift+c=copy_to_clipboard:mixed"
        "performable:ctrl+shift+f=start_search"
        "performable:ctrl+shift+v=paste_from_clipboard"
        "performable:escape=end_search"
        "ctrl+insert=copy_to_clipboard:mixed"
        "shift+insert=paste_from_selection"
      ];

      mouse-hide-while-typing = true;
      notify-on-command-finish = "unfocused";
      notify-on-command-finish-action = "no-bell,notify";
      quick-terminal-autohide = true;
      quick-terminal-size = "30%";
      shell-integration-features = "no-cursor,no-title,ssh-env,ssh-terminfo";
      window-decoration = "none";
      window-padding-balance = "equal";
    };
  };
}
