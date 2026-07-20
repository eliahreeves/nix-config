{...}: {
  flake.modules.nixos.prisismlauncher = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
    persist.userDirectories = [".local/share/PrismLauncher"];
  };
}
