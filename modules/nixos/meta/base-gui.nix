{
  helpers,
  config,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "base-gui";
  cfg = {
    base.enable = true;
    sound-config.enable = true;

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
