{self, ...}: {
  flake.modules.nixos.computerConfiguration = {pkgs, ...}: {
    environment.variables = {
      NH_FLAKE = "/home/erreeves/nix-config";
    };
    imports = with self.modules.nixos; [
      lazygit
      nix-settings
      computerHardware
      niri
      base-gui
      printing
      evolution-data-server
      system76-utils
      capslock-ctrl
      suspend-then-hibernate
      alt-win-swap
      steam
      amd-gpu
      podman
      sops
      comma
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
      docker
      gnome-tools
      opencode
    ];

    nixpkgs.config.allowUnfree = true;

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

    system.stateVersion = "25.05";
    environment.systemPackages = with pkgs; [
      gemini-cli
      cursor-cli
      ungoogled-chromium
      qbittorrent
      zulip
      spotify
      inkscape
      proton-vpn
      gocryptfs
      gapless
      rnote
      texliveFull
      prismlauncher
      devenv
      gimp
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
