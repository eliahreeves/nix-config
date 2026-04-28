{self, ...}: {
  flake.modules.nixos.ghostty = {
    home-manager.sharedModules = [self.modules.homeManager.ghostty];
  };

  flake.modules.homeManager.ghostty = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;
      settings = {
        font-family = "CaskaydiaMono Nerd Font";
        mouse-scroll-multiplier = 0.8;
        font-style = "SemiBold";
        font-style-bold = "ExtraBold";
        font-style-italic = "SemiBold Italic";
        font-style-bold-italic = "ExtraBold Italic";
        font-size = 14;

        palette = [
          "0=#252530"
          "1=#d8647e"
          "2=#7fa563"
          "3=#f3be7c"
          "4=#6e94b2"
          "5=#bb9dbd"
          "6=#aeaed1"
          "7=#cdcdcd"
          "8=#606079"
          "9=#e08398"
          "10=#99b782"
          "11=#f5cb96"
          "12=#8ba9c1"
          "13=#c9b1ca"
          "14=#bebeda"
          "15=#d7d7d7"
        ];

        foreground = "#cdcdcd";
        cursor-color = "#cdcdcd";
        selection-background = "#252530";
        selection-foreground = "#cdcdcd";
        # background-blur = true;
        background-opacity = 0.5;

        background = "#000000";
        keybind = [
          "performable:ctrl+c=copy_to_clipboard"
          "ctrl+v=paste_from_clipboard"
        ];
        window-decoration = "none";
        confirm-close-surface = false;
        quit-after-last-window-closed = true;
        quit-after-last-window-closed-delay = "5m";
      };
    };

    home.sessionVariables = {
      TERMINAL = "${pkgs.ghostty}/bin/ghostty";
    };
  };
}
