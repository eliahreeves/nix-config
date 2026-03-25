{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.ssl-env = {pkgs, ...}: {
    environment.variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
    };
  };
}
