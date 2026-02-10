{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    extra-substituters = [
      "https://eko-network.cachix.org"
      "https://nix-cache.fossi-foundation.org"
    ];
    extra-trusted-public-keys = [
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
    ];
    shell = pkgs.zsh;
  };

  services.upower.enable = true;
  services.flatpak.enable = true;

  base-gui.enable = true;

  home-manager-config = {
    enable = true;
    users = {"erreeves" = ./home.nix;};
  };

  printing.enable = true;
  evolution-data-server.enable = true;
  system76-utils.enable = true;
  power-button-sleep.enable = true;
  capslock-arrow-keys.enable = true;
  alt-win-swap.enable = true;
  hyprland.enable = false;
  niri.enable = true;
  steam.enable = true;
  amd-gpu.enable = true;
  greetd.enable = true;
  podman.enable = true;

  system.stateVersion = "25.05";
}
