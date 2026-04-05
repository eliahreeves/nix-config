{inputs, ...}: {
  flake.modules.homeManager.noctalia = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = false;
      package = pkgs.noctalia-shell.override {calendarSupport = true;};
    };

    home.file = {
      ".config/noctalia".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/noctalia";
    };
  };
}
