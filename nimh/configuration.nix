# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      timeout = 2;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "nimh";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  networking.networkmanager.wifi.powersave = false;

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

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  services.displayManager.defaultSession = "xfce";
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

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

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gnupg
    rsync
    cryptsetup
    vim
    gvfs
    git
    glib
    waypipe
  ];

  openssh.enable = true;
  nimh-networking.enable = true;
  minecraft-server.enable = true;
  samba.enable = true;
  docker.enable = false;
  immich.enable = true;

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

  home-manager = {
    enable = true;
    extraUsers = {
      "rlreeves" = ./home-ryan.nix;
    };
  };
  system.stateVersion = "25.05";
}
