{self, ...}: {
  flake.homeManagerModules.computer-home = {pkgs, ...}: {
    imports = with self.homeManagerModules; [
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
      noctalia
      shell-env
      pulse-vpn
      neovim-symlink
    ];

    home.username = "erreeves";
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
}
