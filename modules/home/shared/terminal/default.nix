{ pkgs, ... }:
{
  home = {
    shell.enableZshIntegration = true;
    shell.enableBashIntegration = false;

    shellAliases = {
      ls = "eza";
      cat = "bat";
    };

    packages = with pkgs; [
      chafa
      fd
      ffmpeg
      imagemagick
      jq
      poppler-utils
      resvg
      ripgrep
      bat
      lazyjournal
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
