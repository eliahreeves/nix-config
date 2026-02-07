{
  helpers,
  config,
  ...
}:
helpers.mkModule config {
  name = "sound-config";
  cfg = {
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
