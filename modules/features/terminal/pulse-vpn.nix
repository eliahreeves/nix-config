## https://discourse.nixos.org/t/build-package-module-for-closed-source-binary-package-pulse-secure-vpn/29628/6
{...}: {
  flake.modules.homeManager.pulse-vpn = {pkgs, ...}: let
    pulse-cookie = pkgs.python3.pkgs.buildPythonApplication rec {
      pname = "pulse-cookie";
      version = "1.0";
      pyproject = true;

      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-ZURSXfChq2k8ktKO6nc6AuVaAMS3eOcFkiKahpq4ebU=";
      };

      build-system = [
        pkgs.python3.pkgs.setuptools
        pkgs.python3.pkgs.setuptools-scm
      ];

      propagatedBuildInputs = [
        pkgs.python3.pkgs.pyqt6
        pkgs.python3.pkgs.pyqt6-webengine
      ];

      preBuild = ''
        cat > setup.py << EOF
        from setuptools import setup

        setup(
          name='pulse-cookie',
          packages=['pulse_cookie'],
          package_dir={"": 'src'},
          version='1.0',
          author='Raj Magesh Gauthaman',
          description='wrapper around openconnect allowing user to log in through a webkit window for mfa',
          install_requires=[
            'PyQt6-WebEngine',
          ],
          entry_points={
            'console_scripts': ['get-pulse-cookie=pulse_cookie._cli:main']
          },
        )
        EOF
      '';

      doCheck = false;

      meta = with pkgs.lib; {
        homepage = "https://pypi.org/project/pulse-cookie/";
        description = "wrapper around openconnect allowing user to log in through a webkit window for mfa";
        license = licenses.gpl3;
      };
    };

    pulse-vpn = pkgs.writeShellScriptBin "pulse-vpn" ''
      HOST=''${1:-"https://ps.vpn.ucsb.edu/ra"}

      echo "Grabbing SAML cookie via PyQt6..."
      DSID=$(${pulse-cookie}/bin/get-pulse-cookie -n DSID $HOST)

      echo "Cookie acquired! Starting openconnect..."
      sudo ${pkgs.openconnect}/bin/openconnect --protocol nc -C DSID=$DSID $HOST
    '';
  in {
    home.packages = [pkgs.openconnect pulse-vpn];
  };
}
