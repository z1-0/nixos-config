{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = ["zh-CN" "en-US"];
    policies = {
      PasswordManagerEnabled = false;
      DisableDeveloperTools = true;
    };
    profiles.default = {
      settings = {
        "browser.tabs.insertAfterCurrent" = true;
        "browser.tabs.insertRelatedAfterCurrent" = true;
        "extensions.autoDisableScopes" = 0; # enable all extensions by default
        "intl.locale.requested" = "zh-CN,en-US";
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        buster-captcha-solver
        kiss-translator
        octotree
        refined-github
        ublock-origin
        vimium
      ];
      search = {
        force = true;
        default = "google";
        engines = {
          "Github" = {
            urls = [{template = "https://github.com/search?q={searchTerms}&type=repositories";}];
            iconMapObj."16" = "https://github.com/favicon.ico";
            definedAliases = ["gh"];
          };
          "SourceGraph" = {
            urls = [{template = "https://sourcegraph.com/search?q={searchTerms}";}];
            iconMapObj."16" = "https://sourcegraph.com/favicon.ico";
            definedAliases = ["sg"];
          };
          bing.metaData.alias = "@b";
          google.metaData.alias = "@g";
        };
      };
    };
  };
}
