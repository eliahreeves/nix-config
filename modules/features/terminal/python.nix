{...}: {
  flake.modules.homeManager.python = {pkgs, ...}: {
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
