{
  helpers,
  config,
  ...
}:
helpers.mkModule config {
  name = "ssl-env";
  cfg = {
    environment.variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
    };
  };
}
