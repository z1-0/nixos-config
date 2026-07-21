{ pkgs, ... }: {
  home = {
    shell.enableZshIntegration = true;
    shell.enableBashIntegration = false;

    shellAliases = {
      cat = "bat";
    };

    packages = with pkgs; [
      bat
      chafa
      fd
      ffmpeg
      imagemagick
      jq
      lazyjournal
      poppler-utils
      resvg
      ripgrep
      translate-shell
    ];
  };

  programs = {
    fzf.enable = true;
    zoxide.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    yazi = {
      enable = true;
      shellWrapperName = "y";
      package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; }; # Support for RAR extraction
    };

    eza = {
      enable = true;
      colors = "auto";
      git = true;
    };
  };
}
