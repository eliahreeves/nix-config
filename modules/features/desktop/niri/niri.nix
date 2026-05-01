{self, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    home-manager.sharedModules = [self.modules.homeManager.niri];
    imports = [
      self.modules.nixos.greetd
    ];
    programs.niri = {
      enable = true;
    };
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      playerctl
      brightnessctl
    ];
  };

  flake.modules.homeManager.niri = {
    pkgs,
    config,
    lib,
    ...
  }: let
    niri-monitor-swap = pkgs.writeShellApplication {
      name = "niri-monitor-swap";
      runtimeInputs = [pkgs.python3];

      text = ''
        set -euo pipefail

        DATA=$(
          python3 - <<'PYEOF'
        import json, subprocess, sys

        workspaces = json.loads(subprocess.check_output(['niri', 'msg', '--json', 'workspaces']))

        active_workspaces = [ws for ws in workspaces if ws['is_active']]
        outputs = list({ws['output'] for ws in active_workspaces})

        if len(outputs) < 2:
            print("ERROR: only one monitor connected", file=sys.stderr)
            sys.exit(1)
        if len(outputs) > 2:
            print("ERROR: more than two monitors connected, ambiguous swap", file=sys.stderr)
            sys.exit(1)

        focused_ws = next(ws for ws in active_workspaces if ws['is_focused'])
        other_ws   = next(ws for ws in active_workspaces if ws['output'] != focused_ws['output'])

        print(focused_ws['active_window_id'], other_ws['active_window_id'],
              focused_ws['output'], other_ws['output'])
        PYEOF
        ) || exit 1

        FOCUSED_WIN=$(echo "$DATA" | cut -d' ' -f1)
        OTHER_WIN=$(echo "$DATA" | cut -d' ' -f2)
        FOCUSED_OUTPUT=$(echo "$DATA" | cut -d' ' -f3)
        OTHER_OUTPUT=$(echo "$DATA" | cut -d' ' -f4)

        niri msg action move-window-to-monitor --id "$OTHER_WIN" "$FOCUSED_OUTPUT"
        niri msg action move-window-to-monitor --id "$FOCUSED_WIN" "$OTHER_OUTPUT"

        niri msg action focus-monitor "$FOCUSED_OUTPUT"

      '';
    };
  in {
    imports = with self.modules.homeManager; [noctalia vlc];
    options.niri.configPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/modules/features/desktop/niri/config";
      description = "Path to niri configuration directory";
    };
    config = {
      home.packages = with pkgs; [
        python313Packages.ipython
        bluetuith
        niri-monitor-swap
      ];

      home.file = {
        ".config/niri".source =
          config.lib.file.mkOutOfStoreSymlink config.niri.configPath;
      };
    };
  };
}
