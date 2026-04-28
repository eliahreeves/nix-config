{...}: {
  flake.modules.nixos.nix-settings = {...}: {
    nix = {
      settings = {
        extra-substituters = [
          "https://eko-network.cachix.org"
          "https://nix-cache.fossi-foundation.org"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "eko-network.cachix.org-1:1xHfovoNlydsTCzXxr5AstUoJUmGR/tRq0PQSCyPab8="
          "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = ["root" "@wheel"];
      };
      optimise = {
        automatic = true;
        dates = "weekly";
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
