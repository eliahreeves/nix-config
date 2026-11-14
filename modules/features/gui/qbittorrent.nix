{...}: {
  flake.modules.nixos.qbittorrent = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      qbittorrent
    ];
    networking.firewall = {
      interfaces."proton0" = {
        allowedTCPPortRanges = [
          {
            from = 1024;
            to = 65535;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 1024;
            to = 65535;
          }
        ];
      };
      checkReversePath = "loose";
    };
    systemd.user.services.proton-portforward = {
      description = "Proton VPN NAT-PMP port forwarding for qBittorrent";
      wantedBy = ["default.target"];
      path = with pkgs; [libnatpmp curl gawk coreutils];
      script = ''
        last=""
        while true; do
          if out=$(natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1); then
            port=$(echo "$out" | awk '/Mapped public port/ {print $4}' | tail -1)
            if [ -n "$port" ] && [ "$port" != "$last" ]; then
              if curl -sf -X POST http://127.0.0.1:8080/api/v2/app/setPreferences \
                   --data-urlencode "json={\"listen_port\":$port}"; then
                echo "qBittorrent port set to $port"
                last=$port
              fi
            fi
          else
            echo "NAT-PMP request failed (VPN down or not a P2P server?)"
            last=""
          fi
          sleep 45
        done
      '';
      serviceConfig.Restart = "always";
    };
  };
}
