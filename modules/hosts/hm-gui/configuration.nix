{self, ...}: {
  flake.modules.homeManager.hmGuiConfiguration = {pkgs, ...}: {
    home.username = "erreeves";
    home.homeDirectory = "/home/erreeves";
    home.stateVersion = "26.05";
    targets.genericLinux.enable = true;
    home.sessionVariables = {
      NH_FLAKE = "/home/erreeves/nix-config/";
      NH_TAG = "hm-gui";
    };
    nixpkgs.config = {
      allowUnfree = true;
    };
    imports = with self.modules.homeManager; [
      zsh
      tmux
      ghostty
      zen-browser
      cursor-cli
      lazygit
      git
      direnv
    ];

    home.packages = with pkgs; [
      prismlauncher
      signal-desktop
      typst
      btop
      self.packages.${pkgs.stdenv.hostPlatform.system}.neovim
    ];

    programs.home-manager.enable = true;
  };
}
