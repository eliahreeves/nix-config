{self, ...}: {
  flake.modules.nixos.nimhConfiguration = {pkgs, ...}: {
    environment.variables = {
      NH_FLAKE = "/home/erreeves/nix-config/";
    };

    imports = with self.modules.nixos; [
      trading
      nimhHardware
      neovim
      base-gui
      no-sleep
      openssh
      minecraft-server
      samba
      immich
      eko-messenger
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
      kernelPackages = pkgs.linuxPackages_latest;
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

    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };

    services.displayManager.defaultSession = "xfce";
    users.groups.nix-admins = {};

    users.users.erreeves = {
      isNormalUser = true;
      description = "Eliah Reeves";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "nix-admins"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJT4WXnfL1SCvyBo6p3+pUNSBI+ZxyTADd4NzX5GKd0Z ereeclimb@gmail.com"
      ];
    };
    users.users.ctknab = {
      isNormalUser = true;
      description = "Christian";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "nix-admins"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZnymIHOfUPHQuCbaW8aPC9lkrV7kHBaE0sEQDaykG3 christiantknab@gmail.com"
      ];
    };
    users.users.ericbreh = {
      isNormalUser = true;
      description = "Eric";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "nix-admins"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOanOZf0P4dP7gnyYLQ8WcxTm3ln5rFZE+J/1RhTewVR ericchuang94@gmail.com"
      ];
    };
    users.users.rlreeves = {
      isNormalUser = true;
      description = "Ryan Reeves";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrsuj0ydqjTHAmiTyVTFsWl3HHGKglxYQVQdlvNa/hL 75mmnorm@gmail.com"
      ];
    };

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
