{
  helpers,
  config,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "base";
  cfg = {
    locale.enable = true;
    nix-ld.enable = true;
    ssl-env.enable = true;
    security.rtkit.enable = true;

    networking.networkmanager.enable = true;

    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      gnupg
      rsync
      cryptsetup
      vim
      git
    ];
  };
}
