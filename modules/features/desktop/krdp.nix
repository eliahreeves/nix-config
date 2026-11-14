{...}: {
  flake.modules.nixos.krdp = {pkgs, ...}: {
    systemd.user.units."app-org.kde.krdpserver.service" = {
      overrideStrategy = "asDropin";
      text = ''
        [Service]
        ExecStart=
        ExecStart=${pkgs.kdePackages.krdp}/bin/krdpserver --virtual-monitor 1920x1080@1
      '';
    };

    environment.etc."xdg/autostart/lock-on-autologin.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Lock on autologin
      Exec=${pkgs.writeShellScript "lock-on-autologin" ''
        service=$(${pkgs.systemd}/bin/loginctl show-session "$XDG_SESSION_ID" -p Service --value)
        if [ "$service" = plasmalogin-autologin ]; then
          ${pkgs.systemd}/bin/loginctl lock-session "$XDG_SESSION_ID"
        fi
      ''}
      OnlyShowIn=KDE;
      NoDisplay=true
    '';
  };
}
