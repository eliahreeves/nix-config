## https://discourse.nixos.org/t/build-package-module-for-closed-source-binary-package-pulse-secure-vpn/29628/6
{...}: {
  flake.modules.nixos.pulse-vpn = {pkgs, ...}: let
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

    pulse-sandbox = pkgs.writeShellScriptBin "pulse-sandbox" ''
      NS_NAME="vpn-box"
      VETH_HOST="veth-host"
      VETH_NS="veth-ns"
      HOST_IP="10.200.1.1"
      NS_IP="10.200.1.2"

      setup_ns() {
        echo "Creating network namespace: $NS_NAME"
        sudo ip netns add "$NS_NAME"
        sudo ip link add "$VETH_HOST" type veth peer name "$VETH_NS"
        sudo ip link set "$VETH_NS" netns "$NS_NAME"

        sudo ip addr add "$HOST_IP/24" dev "$VETH_HOST"
        sudo ip link set "$VETH_HOST" up

        sudo ip netns exec "$NS_NAME" ip addr add "$NS_IP/24" dev "$VETH_NS"
        sudo ip netns exec "$NS_NAME" ip link set "$VETH_NS" up
        sudo ip netns exec "$NS_NAME" ip link set lo up
        sudo ip netns exec "$NS_NAME" ip route add default via "$HOST_IP"

        # Enable NAT so the namespace can reach the internet through the host
        HOST_IFACE=$(ip route get 1.1.1.1 2>/dev/null | awk '/dev/{print $5; exit}')
        sudo iptables -t nat -A POSTROUTING -s "$NS_IP/24" -o "$HOST_IFACE" -j MASQUERADE
        sudo iptables -A FORWARD -i "$VETH_HOST" -o "$HOST_IFACE" -j ACCEPT
        sudo iptables -A FORWARD -i "$HOST_IFACE" -o "$VETH_HOST" -m state --state RELATED,ESTABLISHED -j ACCEPT
        sudo sysctl -q net.ipv4.ip_forward=1
      }

      # Recreate if namespace missing or veth pair is gone
      if ! ip netns list | grep -q "$NS_NAME" || ! ip link show "$VETH_HOST" &>/dev/null; then
        ip netns list | grep -q "$NS_NAME" && sudo ip netns del "$NS_NAME"
        ip link show "$VETH_HOST" &>/dev/null && sudo ip link del "$VETH_HOST"
        setup_ns
      fi

      sudo mkdir -p /etc/netns/"$NS_NAME"
      echo "nameserver 8.8.8.8" | sudo tee /etc/netns/"$NS_NAME"/resolv.conf > /dev/null

      echo "Acquiring SAML cookie..."
      HOST=''${1:-"https://ps.vpn.ucsb.edu/ra"}
      DSID=$(${pulse-cookie}/bin/get-pulse-cookie -n DSID $HOST)

      echo "Starting VPN inside namespace..."
      sudo ip netns exec "$NS_NAME" ${pkgs.openconnect}/bin/openconnect --protocol nc -C DSID=$DSID $HOST
    '';

    pulse-vpn = pkgs.writeShellScriptBin "pulse-vpn" ''
      HOST=''${1:-"https://ps.vpn.ucsb.edu/ra"}

      echo "Grabbing SAML cookie via PyQt6..."
      DSID=$(${pulse-cookie}/bin/get-pulse-cookie -n DSID $HOST)

      echo "Cookie acquired! Starting openconnect..."
      sudo ${pkgs.openconnect}/bin/openconnect --protocol nc -C DSID=$DSID $HOST
    '';
  in {
    environment.systemPackages = [pkgs.openconnect pulse-vpn pulse-sandbox];
  };
}
