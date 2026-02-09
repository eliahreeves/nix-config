{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "nnn";
  cfg = {
    programs.nnn = {
      enable = true;
      plugins = {};
      extraPackages = with pkgs; [
        less
        tree
        file
        mediainfo
        mktemp
        unzip
        gnutar
        man
        bat
        chafa
        imagemagick
        ffmpegthumbnailer
        poppler-utils
        dragon-drop
      ];
      plugins.src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v5.0";
          sha256 = "sha256-HShHSjqD0zeE1/St1Y2dUeHfac6HQnPFfjmFvSuEXUA=";
        })
        + "/plugins";
      plugins.mappings = {
        p = "preview-tui";
        d = "dragdrop";
      };
    };
    home.sessionVariables = {
      NNN_FIFO = "/tmp/nnn.fifo";
      NNN_PREVIEWIMGPROG = "chafa";
      NNN_TRASH = "1";
    };
    programs.zsh.shellAliases = {
      nnn = "nnn -ae -P p";
    };
  };
}
