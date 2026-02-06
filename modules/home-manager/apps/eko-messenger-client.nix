{
  pkgs,
  config,
  inputs,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "eko-messenger-client";
  cfg = {
    home.packages = [
      inputs.eko-messenger-client.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
