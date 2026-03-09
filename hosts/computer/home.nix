{pkgs, ...}: {
  home.username = "erreeves";
  home.stateVersion = "25.05"; # Please read the comment before changing.
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

  signal.enable = true;
  minecraft.enable = true;
  ghostty.enable = true;
  firefox.enable = true;
  eko-messenger-client.enable = true;
  niri-utils.enable = true;
  zen-browser.enable = true;
  gnome-tools.enable = true;
  theme.enable = true;
  vscode.enable = true;
  latex.enable = true;
  python.enable = true;
  noctalia.enable = true;
  shell-env.enable = true;
  ai.enable = true;
  kunifiedpush.enable = false;
  pulse-vpn.enable = true;

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
}
