{self, ...}: {
  flake.modules.nixos.foot = {
    home-manager.sharedModules = [self.modules.homeManager.foot];
  };

  flake.modules.homeManager.foot = {
    pkgs,
    lib,
    ...
  }: {
    home.sessionVariables = {
      TERMINAL = lib.getExe pkgs.foot;
    };

    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "CaskaydiaMono Nerd Font:size=14:style=SemiBold";
          font-bold = "CaskaydiaMono Nerd Font:size=14:style=ExtraBold";
          font-italic = "CaskaydiaMono Nerd Font:size=14:style=SemiBold Italic";
          font-bold-italic = "CaskaydiaMono Nerd Font:size=14:style=ExtraBold Italic";
        };

        colors-dark = {
          alpha = "0.4";
          foreground = "cdcdcd";
          background = "000000";
          selection-foreground = "cdcdcd";
          selection-background = "252530";

          regular0 = "252530";
          regular1 = "d8647e";
          regular2 = "7fa563";
          regular3 = "f3be7c";
          regular4 = "6e94b2";
          regular5 = "bb9dbd";
          regular6 = "aeaed1";
          regular7 = "cdcdcd";

          bright0 = "606079";
          bright1 = "e08398";
          bright2 = "99b782";
          bright3 = "f5cb96";
          bright4 = "8ba9c1";
          bright5 = "c9b1ca";
          bright6 = "bebeda";
          bright7 = "d7d7d7";

          cursor = "000000 cdcdcd";
        };

        csd = {
          preferred = "none";
        };

        key-bindings = {
          clipboard-copy = "Control+c";
          clipboard-paste = "Control+v";
        };
      };
    };
  };
}
