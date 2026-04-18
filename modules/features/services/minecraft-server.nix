{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.minecraft-server = {pkgs, ...}: {
    imports = [
      inputs.nix-minecraft.nixosModules.minecraft-servers
    ];

    nixpkgs.overlays = [
      inputs.nix-minecraft.overlay
    ];

    services.minecraft-servers = {
      enable = true;
      eula = true;
      dataDir = "/srv/minecraft";
      openFirewall = true;
      servers.eko = {
        enable = true;
        package = pkgs.vanillaServers.vanilla;
        whitelist = {
          nunibye = "a40b5a6d-70eb-488f-b0b9-b57af0127d03";
          TomorrowSalmon = "337b540e-79ee-4764-bb44-2ecc6ac690f8";
          knabster03 = "b96d9fd1-8551-4bae-8bd6-2589e4fc31f1";
          FlyingFish800 = "1b01dfa9-e9bc-432d-9063-33fc20616eb6";
          uiscupcake19 = "68a5d05a-1a39-4ea8-ba9c-4219498676b2";
          ericbreh = "dc4e6ed0-55fe-41b7-b969-34894258c430";
          studfinder_walls = "4f9db19a-2dc0-460e-a374-8331c2e79e20";
          TSbrisaPMO = "429a0d8d-a28e-42d1-8a8b-1bf809130e3f";
          Blue_Sushi = "c12ddbb3-ca9b-4fde-b485-e75b597ecc5c";
          brucec_sann = "143911d3-c562-4b54-ae8e-d751f043b8f7";
        };
        serverProperties = {
          level-name = "world";
          difficulty = "hard";
          view-distance = 18;
          white-list = true;
        };
      };
    };
  };
}
