{
  programs.ghostty = {
    enable = true;
    settings = {
      app-notifications = "no-clipboard-copy,no-config-reload";

      # Work around Ghostty(GTK) clipboard getting stuck under wlroots:
      # rejected OSC 52 writes leave GTK thinking it owns the clipboard.
      # Local copy still works; remote OSC 52 over ssh/tmux is disabled.
      # Upstream: https://github.com/ghostty-org/ghostty/discussions/13903
      clipboard-write = "deny";

      copy-on-select = "none";
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
