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
      jvmOpts = "-Xmx4096M -Xms1024M";
      dataDir = "/srv/minecraft";
      declarative = true;
      openFirewall = true;
      whitelist = {
        nunibye = "a40b5a6d-70eb-488f-b0b9-b57af0127d03";
        TomorrowSalmon = "337b540e-79ee-4764-bb44-2ecc6ac690f8";
        knabster03 = "b96d9fd1-8551-4bae-8bd6-2589e4fc31f1";
        FlyingFish800 = "1b01dfa9-e9bc-432d-9063-33fc20616eb6";
        uiscupcake19 = "68a5d05a-1a39-4ea8-ba9c-4219498676b2";
        ericbreh = "dc4e6ed0-55fe-41b7-b969-34894258c430";
      };
      serverProperties = {
        level-name = "world";
        difficulty = "hard";
        view-distance = 18;
        white-list = true;
      };
    };
    # systemd.services.minecraft-server.wantedBy = lib.mkForce [];
  };
}
