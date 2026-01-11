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
  nix.settings = {
    # extra-substituters = ["https://nix-cache.fossi-foundation.org"];
    # extra-trusted-public-keys = ["nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    # inputs.eko-messenger.nixosModules.default
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      timeout = 1;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "computer";

  networking.networkmanager.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

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

  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gnupg
    rsync
    cryptsetup
    vim
    git
    protonvpn-gui
  ];

  environment.variables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    SSL_CERT_DIR = "/etc/ssl/certs";
  };

  system76-utils.enable = true;
  power-button-sleep.enable = true;
  minecraft-server.enable = true;
  adwaita-qt.enable = true;
  capslock-arrow-keys.enable = true;
  alt-win-swap.enable = true;
  hyprland.enable = false;
  niri.enable = true;
  steam.enable = true;
  distrobox.enable = true;
  amd-gpu.enable = true;
  services.envfs.enable = true;
  home-manager.enable = true;
  greetd.enable = true;
  services.flatpak.enable = true;
  dms.enable = true;

  system.stateVersion = "25.05";

  # services.eko-messenger = {
  #   enable = false;
  #   domain = "127.0.0.1:3000";
  #   firebaseApiKey = "";
  #   jwtSecret = "";
  # };
}
