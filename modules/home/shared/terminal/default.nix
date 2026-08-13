{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  home = {
    shell.enableZshIntegration = true;
    shell.enableBashIntegration = false;

    shellAliases = {
      cat = "bat";
    }
    # Remove built-in l/ll/ls aliases to prevent them from shadowing eza.
    // lib.removeAttrs osConfig.environment.shellAliases [
      "l"
      "ll"
      "ls"
    ];

    packages = with pkgs; [
      bat
      chafa
      fd
      ffmpeg
      imagemagick
      jq
      lazyjournal
      libarchive
      poppler-utils
      resvg
      ripgrep
      translate-shell
    ];
  };

  programs = {
    zoxide.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      colors = "auto";
      git = true;
    };

    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };

    yazi = {
      enable = true;
      shellWrapperName = "y";
      package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; }; # Support for RAR extraction
    };
  };

}
