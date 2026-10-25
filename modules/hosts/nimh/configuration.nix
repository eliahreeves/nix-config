{self, ...}: {
  flake.modules.nixos.nimhConfiguration = {pkgs, ...}: {
    environment.variables = {
      NH_FLAKE = "/home/erreeves/nix-config/";
    };

    imports = with self.modules.nixos; [
      jellyfin
      gnome
      tailscale
      # trading
      nimhHardware
      neovim
      base-gui
      no-sleep
      openssh
      erreeves
      rlreeves
      minecraft-server
      samba
      immich
      # eko-messenger
      restic-backup
      tmux
      git
      zsh
    ];

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      extra-substituters = [
        "https://eko-network.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "eko-network.cachix.org-1:1xHfovoNlydsTCzXxr5AstUoJUmGR/tRq0PQSCyPab8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = ["root" "@wheel"];
    };

    boot = {
      kernelPackages = pkgs.linuxPackages;
      loader = {
        systemd-boot.enable = true;
        timeout = 2;
        efi.canTouchEfiVariables = true;
      };
    };

    networking.hostName = "nimh";

    fileSystems = {
      "/srv/immich" = {
        device = "/dev/disk/by-label/data";
        fsType = "btrfs";
        options = ["subvol=@subvolumes/immich" "compress=zstd" "noatime"];
      };
      "/srv/jelly" = {
        device = "/dev/disk/by-label/data";
        fsType = "btrfs";
        options = ["subvol=@subvolumes/jelly" "compress=zstd" "noatime"];
      };
      "/srv/media" = {
        device = "/dev/disk/by-label/data";
        fsType = "btrfs";
        options = ["subvol=@subvolumes/media" "compress=zstd" "noatime"];
      };
      "/srv/share" = {
        device = "/dev/disk/by-label/data";
        fsType = "btrfs";
        options = ["subvol=@subvolumes/share" "compress=zstd" "nodiratime"];
      };
      "/srv/minecraft" = {
        device = "/dev/disk/by-label/data";
        fsType = "btrfs";
        options = ["subvol=@subvolumes/minecraft" "compress=zstd" "noatime"];
      };
    };

    users.groups.nix-admins = {};

    users.users.erreeves.extraGroups = ["nix-admins"];

    home-manager = {
      users.erreeves = {
        home = {
          username = "erreeves";
          homeDirectory = "/home/erreeves";
          stateVersion = "25.05";
        };
        git = {
          email = "ereeclimb@gmail.com";
          name = "Eliah Reeves";
          sign = false;
        };
        tmux.prefix = "b";
      };
    };
    system.stateVersion = "25.05";
  };
}
