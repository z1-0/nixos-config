{
  programs.ghostty = {
    enable = true;
    settings = {
      copy-on-select = false;
      mouse-hide-while-typing = true;
      window-decoration = "none";
      app-notifications = "no-clipboard-copy,no-config-reload";
      shell-integration-features = "cursor,no-cursor,sudo,no-sudo,title,no-title,ssh-env,ssh-terminfo";
    };
  };
}
