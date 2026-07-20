{self, ...}: {
  flake.modules.nixos.machine-configuration = {pkgs, ...}: {
    environment.variables = {
      NH_FLAKE = "/home/erreeves/nix-config/";
    };

    imports = with self.modules.nixos; [
      persist-dev
      organicmaps
      signal
      steam
      tuned
      undervolt
      capslock-arrow-keys
      theme
      alt-win-swap
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
      vscode
      gnome-tools
      qbittorrent
      prisismlauncher
      ai
    ];
    # hardware.graphics = {
    #   enable = true;
    #   enable32Bit = true;
    #
    #   extraPackages = with pkgs; [
    #     intel-media-driver
    #     intel-vaapi-driver
    #     libvdpau-va-gl
    #   ];
    #
    #   extraPackages32 = with pkgs.pkgsi686Linux; [
    #     intel-media-driver
    #     intel-vaapi-driver
    #     libvdpau-va-gl
    #   ];
    # };
    persist = {
      enable = true;
      user = "erreeves";
    };

    environment.systemPackages = with pkgs; [
      undervolt
      s-tui
      stress
    ];

    nixpkgs.config.allowUnfree = true;

    security.sudo.extraConfig = ''
      Defaults lecture=never
    '';
    boot = {
      kernelPackages = pkgs.linuxPackages;
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
        isNormalUser = true;
        description = "Eliah Reeves";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "nix-admins"
        ];
        shell = pkgs.zsh;
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
