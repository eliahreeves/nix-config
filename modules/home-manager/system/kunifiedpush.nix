{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.mkModule config {
  name = "kunifiedpush";
  cfg = {
    home.packages = with pkgs; [
      kdePackages.kunifiedpush
    ];
    home.file.".config/KDE/kunifiedpush-distributor.conf".text = ''
      [PushProvider]
      Type=Autopush

      [Autopush]
      Url=https://push.services.mozilla.com
    '';

    systemd.user.services.kunifiedpush = {
      Unit = {
        Description = "KUnifiedPush Distributor Service";
        After = ["network-online.target"];
      };

      Service = {
        ExecStart = "${pkgs.kdePackages.kunifiedpush}/bin/kunifiedpush-distributor";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
