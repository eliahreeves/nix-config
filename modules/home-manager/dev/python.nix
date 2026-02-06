{
  pkgs,
  config,
  helpers,
  ...
}:
helpers.mkModule config {
  name = "python";
  cfg = {
    home.packages = with pkgs; [
      (python312.withPackages (p:
        with p; [
          numpy
          pandas
          matplotlib
          seaborn
        ]))
    ];
  };
}
