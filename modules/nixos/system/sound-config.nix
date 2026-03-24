{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sound-config = {pkgs, ...}: {
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
