{
  programs.ghostty = {
    enable = true;
    settings = {
      copy-on-select = false;

      # Work around Ghostty(GTK) clipboard getting stuck under wlroots:
      # rejected OSC 52 writes leave GTK thinking it owns the clipboard.
      # Local copy still works; remote OSC 52 over ssh/tmux is disabled.
      # Upstream: https://github.com/ghostty-org/ghostty/discussions/13903
      clipboard-write = "deny";

      mouse-hide-while-typing = true;
      window-decoration = "none";
      app-notifications = "no-clipboard-copy,no-config-reload";
      shell-integration-features = "cursor,no-cursor,sudo,no-sudo,title,no-title,ssh-env,ssh-terminfo";
    };
  };
}
