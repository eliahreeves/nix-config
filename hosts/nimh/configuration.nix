{
  pkgs,
  inputs,
  ...
}: {
  environment.variables = {
    NH_FLAKE = "/etc/nixos";
  };

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    extra-substituters = [
      "https://eko-network.cachix.org"
    ];
    extra-trusted-public-keys = [
      "eko-network.cachix.org-1:1xHfovoNlydsTCzXxr5AstUoJUmGR/tRq0PQSCyPab8="
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
    "/srv/postgres" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = ["subvol=@subvolumes/postgres" "compress=zstd" "noatime"];
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

  users.users.erreeves = {
    isNormalUser = true;
    description = "Eliah Reeves";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
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
  };

  environment.systemPackages = with pkgs; [
    waypipe
  ];

  base-gui.enable = true;

  home-manager-config = {
    enable = true;
    users = {
      "erreeves" = ./home.nix;
      "rlreeves" = ./home-ryan.nix;
    };
  };

  no-sleep.enable = true;

  openssh.enable = true;
  minecraft-server.enable = true;
  samba.enable = true;
  immich.enable = true;
  eko-messenger.enable = true;

  # fileSystems."/mnt/theratpack" = {
  #   device = "//192.168.0.123/theratpack";
  #   fsType = "cifs";
  #   options = [
  #     "credentials=/etc/nixos/smbcredentials"
  #     "uid=1000" # Your user UID
  #     "gid=1000" # Your group GID
  #     "iocharset=utf8"
  #     "vers=3.0" # SMB protocol version
  #   ];
  # };

  system.stateVersion = "25.05";
}
