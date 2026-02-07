{
  config,
  helpers,
  pkgs,
  ...
}: let
  templateSource = ./templates;
  tmplt-script = pkgs.replaceVars ./tmplt.lua {
    templatePath = "${templateSource}";
  };
  tmplt-package = pkgs.writeShellApplication {
    name = "tmplt";
    runtimeInputs = [pkgs.lua5_4];
    text = ''
      lua ${tmplt-script} "$@"
    '';
  };
  tmplt-completion = pkgs.writeTextFile {
    name = "tmplt-completion";
    destination = "/share/zsh/site-functions/_tmplt";
    text = ''
      #compdef tmplt
      _tmplt() {
          local -a commands templates
          commands=('list')

          if [[ -d "${templateSource}" ]]; then
              templates=($(ls -1 "${templateSource}"))
          fi

          _arguments '1: :->cmds'
          case $state in
              cmds)
                  _describe 'command' commands
                  _multi_parts / templates
                  ;;
          esac
      }
      _tmplt "$@"
    '';
  };
in
  helpers.mkModule config {
    name = "tmplt";
    cfg = {
      home.packages = [tmplt-package tmplt-completion];
    };
  }
