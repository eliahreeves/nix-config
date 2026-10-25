{self, ...}: {
  flake.modules.nixos.machine-configuration = {pkgs, ...}: {
    environment.variables = {
      NH_FLAKE = "/home/erreeves/nix-config/";
    };
    imports = with self.modules.nixos; [
      kicad
      erreeves
      helium
      artcraft
      kdenlive
      tailscale
      distrobox
      pulse-vpn
      comaps
      signal
      steam
      tuned
      printing
      undervolt
      capslock-arrow-keys
      theme
      alt-win-swap
      docker
      neovim-full
      default-apps
      firefox
      niri
      tmux
      nix-settings
      hm-dir
      base-gui
      git
      zsh
      foot
      comma
      proton-vpn
      direnv
      tmplt
      python
      vscodium
      gnome-tools
      qbittorrent
      prisismlauncher
      ai
    ];

    persist = {
      enable = true;
      directories = [
        {
          directory = "/home/erreeves";
          user = "erreeves";
          group = "users";
          mode = "0700";
        }
      ];
    };

    environment.systemPackages = with pkgs; [
      undervolt
      spotify
      s-tui
      stress
      typst
      texliveFull
      gh
      ffmpeg-headless
      mindustry-wayland
      freerdp
      ffmpegthumbnailer
    ];

    nixpkgs.config.allowUnfree = true;

    security.sudo.extraConfig = ''
      Defaults lecture=never
    '';
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        systemd-boot.enable = true;
        timeout = 1;
        efi.canTouchEfiVariables = true;
      };
    };

    networking.hostName = "machine";
    users = {
      mutableUsers = false;
      users.erreeves = {
        hashedPasswordFile = "/persistent/home/erreeves/.secrets/user-password-hash";
        extraGroups = ["nix-admins"];
      };
    };

    home-manager = {
      users.erreeves = {
        home = {
          username = "erreeves";
          homeDirectory = "/home/erreeves";
          stateVersion = "25.05";
        };
        foot.font-size = 12;
        git = {
          email = "ereeclimb@gmail.com";
          name = "Eliah Reeves";
          sign = false;
        };
      };
    };
    system.stateVersion = "25.05";
  };
}
