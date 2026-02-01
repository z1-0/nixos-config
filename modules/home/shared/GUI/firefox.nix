{ flake, pkgs, ... }:
{
  imports = [ flake.inputs.betterfox.modules.homeManager.betterfox ];

  programs.firefox = {
    enable = true;
    languagePacks = [
      "zh-CN"
      "en-US"
    ];
    betterfox = {
      enable = true;
      profiles.default = {
        enableAllSections = true;
        settings = {
          fastfox.enable = true;
          peskyfox.enable = true;
          securefox.enable = true;
          smoothfox.sharpen-scrolling.enable = true;
        };
      };
    };

    profiles.default = {
      settings = {
        "intl.locale.requested" = "zh-CN,en-US";
        "browser.tabs.insertAfterCurrent" = true;
        "browser.tabs.insertRelatedAfterCurrent" = true;
        "extensions.autoDisableScopes" = 0; # enable all extensions by default
      };
      extensions =
        let
          # TODO 🚨
          ignoreVulnerabilities =
            pkg:
            pkg.overrideAttrs (oldAttrs: {
              meta = oldAttrs.meta // {
                knownVulnerabilities = [ ];
              };
            });
        in
        {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            firefox-color
            octotree
            refined-github
            bitwarden
            buster-captcha-solver
            (ignoreVulnerabilities immersive-translate)
          ];
        };
      search = {
        force = true;
        default = "google";
        engines = {
          "Github" = {
            urls = [ { template = "https://github.com/search?q={searchTerms}&type=repositories"; } ];
            iconMapObj."16" = "https://github.com/favicon.ico";
            definedAliases = [ "gh" ];
          };
          "SourceGraph" = {
            urls = [ { template = "https://sourcegraph.com/search?q={searchTerms}"; } ];
            iconMapObj."16" = "https://sourcegraph.com/favicon.ico";
            definedAliases = [ "sg" ];
          };
          "searchix" = {
            urls = [ { template = "https://searchix.ovh/?query={searchTerms}"; } ];
            iconMapObj."16" = "https://searchix.ovh/favicon.ico";
            definedAliases = [ "no" ]; # nix options
          };
          "noogle" = {
            urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
            iconMapObj."16" = "https://noogle.dev/favicon.ico";
            definedAliases = [ "nf" ]; # nix function
          };
          bing.metaData.alias = "@b";
          google.metaData.alias = "@g";
        };
      };
    };
  };
}
