{self, ...}: {
  flake.modules.homeManager.computer-home = {pkgs, ...}: {
    imports = with self.modules.homeManager; [
      neovim

      ai
      signal
      minecraft
      ghostty
      firefox
      niri-utils
      zen-browser
      gnome-tools
      theme
      vscode
      latex
      python
      shell-env
      pulse-vpn
    ];

    home.username = "erreeves";
    home.homeDirectory = "/home/erreeves";
    home.stateVersion = "25.05";
    home.packages = with pkgs; [
      aerc
      ungoogled-chromium
      qbittorrent
      zulip
      spotify
      gh
      inkscape
      quickemu
      protonvpn-gui
      gocryptfs
      gapless
      esptool
      rnote
    ];

    gtk.gtk3.bookmarks = let
      homePath = "file:///home/erreeves/";
      folders = [
        "repos"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
        "Audiobooks"
        "Music"
      ];
    in
      map (folder: "${homePath}${folder}") folders;

    programs = {
      home-manager.enable = true;
    };
  };

  # flake.homeConfigurations.erreeves = inputs.home-manager.lib.homeManagerConfiguration {
  #   pkgs = inputs.nixpkgs;
  #   extraSpecialArgs = {inherit inputs;};
  #   modules = [
  #     {nixpkgs.config.allowUnfree = true;}
  #     self.modules.homeManager.computer-home
  #   ];
  # };
}
