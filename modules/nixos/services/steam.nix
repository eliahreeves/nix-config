{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.steam = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
