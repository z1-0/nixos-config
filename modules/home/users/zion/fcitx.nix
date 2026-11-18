{ pkgs, ... }:
{
  gtk.enable = true;

  home.sessionVariables.QT_IM_MODULES = "wayland;fcitx";

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        fcitx5-gtk
        qt6Packages.fcitx5-chinese-addons
      ];

      settings = {
        globalOptions = {
          "Behavior/DisabledAddons" = {
            "0" = "clipboard";
          };

          Hotkey = {
            ActivateKeys = "";
            DeactivateKeys = "";
            EnumerateGroupBackwardKeys = "";
            EnumerateGroupForwardKeys = "";
            EnumerateWithTriggerKeys = false;
            NextCandidate = "";
            NextPage = "";
            PrevCandidate = "";
            PrevPage = "";
            TogglePreedit = "";
          };

          "Hotkey/AltTriggerKeys" = { };

          "Hotkey/TriggerKeys" = {
            "0" = "Shift_L";
            "1" = "Shift_R";
          };
        };

        inputMethod = {
          GroupOrder."0" = "Default";

          "Groups/0" = {
            "Default Layout" = "us";
            DefaultIM = "pinyin";
            Name = "Default";
          };

          "Groups/0/Items/0".Name = "keyboard-us";

          "Groups/0/Items/1".Name = "pinyin";
        };

        addons = {
          chttrans.globalSection.Hotkey = "";

          cloudpinyin.globalSection = {
            Backend = "Baidu";
            "Toggle Key" = "";
          };

          keyboard.globalSection = {
            "Hint Trigger" = "";
            NextCandidate = "";
            "One Time Hint Trigger" = "";
            PrevCandidate = "";
          };

          pinyin = {
            globalSection = {
              CloudPinyinEnabled = true;
              FirstRun = false;
              ForgetWord = "";
              NextCandidate = "";
              PrevCandidate = "";
            };

            sections.CommitRawInput."0" = "Return";
          };

          punctuation.globalSection.Hotkey = "";

          quickphrase.globalSection.TriggerKey = "";

          table.globalSection = {
            ForgetWord = "";
            LookupPinyinKey = "";
            ModifyDictionaryKey = "";
          };

          unicode.globalSection = {
            DirectUnicodeMode = "";
            TriggerKey = "";
          };
        };
      };

    };
  };
}
