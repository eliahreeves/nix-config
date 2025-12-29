{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    samba.enable = lib.mkEnableOption "Enable samba";
  };
  config = lib.mkIf config.samba.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "nimh";
          "netbios name" = "nimh";
          "security" = "user";
          "hosts allow" = "192.168.0. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "public" = {
          "path" = "/srv/share/public";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "nobody";
          "force group" = "nogroup";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
