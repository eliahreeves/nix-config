{...}: {
  flake.modules.nixos.prisismlauncher = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };
}
