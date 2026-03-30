{self, ...}: {
  flake.modules.nixos.computerConfiguration = {pkgs, ...}: {
    environment.variables = {
      NH_FLAKE = "/home/erreeves/nix-config/";
    };
    imports = with self.modules.nixos; [
      computerHardware
      niri
      base-gui
      printing
      evolution-data-server
      system76-utils
      power-button-sleep
      capslock-ctrl
      alt-win-swap
      steam
      amd-gpu
      podman
      sops
      tmux
      neovim-full
      theme
      zen-browser
      zsh
      direnv
      tmplt
      python
      git
      pulse-vpn
      signal
      ghostty
      firefox
      vscode
      gnome-tools
      opencode
    ];

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      extra-substituters = [
        "https://eko-network.cachix.org"
        "https://nix-cache.fossi-foundation.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "eko-network.cachix.org-1:1xHfovoNlydsTCzXxr5AstUoJUmGR/tRq0PQSCyPab8="
        "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
      ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = ["root" "@wheel"];
    };

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        systemd-boot.enable = true;
        timeout = 1;
        efi.canTouchEfiVariables = true;
      };
    };

    networking.hostName = "computer";

    users.users.erreeves = {
      isNormalUser = true;
      description = "Eliah Reeves";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "podman"
        "dialout"
      ];
      shell = pkgs.zsh;
    };

    services.upower.enable = true;
    services.flatpak.enable = true;

    services.tlp.enable = true;
    system.stateVersion = "25.05";
    environment.systemPackages = with pkgs; [
      ungoogled-chromium
      qbittorrent
      zulip
      spotify
      inkscape
      protonvpn-gui
      gocryptfs
      gapless
      rnote
      texliveFull
      prismlauncher
    ];

    home-manager = {
      users.erreeves = {
        home = {
          username = "erreeves";
          homeDirectory = "/home/erreeves";
          stateVersion = "25.05";
        };
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
        git = {
          email = "ereeclimb@gmail.com";
          name = "Eliah Reeves";
        };
      };
    };
  };
}
