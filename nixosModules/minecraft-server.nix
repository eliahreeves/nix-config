{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    minecraft-server.enable = lib.mkEnableOption "Minecraft server";
  };
  config = lib.mkIf config.minecraft-server.enable {
    services.minecraft-server = {
      enable = true;
      eula = true;
      jvmOpts = "-Xmx8192M -Xms2048M";
      declarative = true;
      openFirewall = true;
      whitelist = {
        nunibye = "a40b5a6d-70eb-488f-b0b9-b57af0127d03";
        TomorrowSalmon = "337b540e-79ee-4764-bb44-2ecc6ac690f8";
        knabster03 = "b96d9fd1-8551-4bae-8bd6-2589e4fc31f1";
      };
      serverProperties = {
        level-name = "eli-world";
        difficulty = "hard";
        view-distance = 18;
        white-list = true;
      };
    };
    systemd.services.minecraft-server.wantedBy = lib.mkForce [];
  };
}
