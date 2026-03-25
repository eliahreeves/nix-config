{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.base-gui = {pkgs, ...}: {
    imports = with self.modules.nixos; [base sound-config];

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

    # fixes some issues with rendering svgs in certain places. Not very important.
    programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];

    # Make disk io feel more desktop friendly (external drives and stuff)
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
