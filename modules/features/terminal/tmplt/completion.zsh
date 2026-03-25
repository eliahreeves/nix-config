#compdef tmplt

_tmplt() {
  local -a templates
  local template_dir="@templatePath@"
  
  # Get the list of available templates
  if [[ -d "$template_dir" ]]; then
    templates=("${(@f)$(find "$template_dir" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; 2>/dev/null)}")
  fi
  
  # Define the command line arguments
  _arguments \
    '1: :->command' \
    '*: :->args'
    
  case $state in
    command)
      # Complete with 'list' command or template names
      _describe -t commands 'tmplt command' "list" "list available templates"
      if [[ -n "$templates" ]]; then
        _describe -t templates 'tmplt templates' templates
      fi
      ;;
    args)
      # If the first argument was a template name, no additional arguments expected
      # If the first argument was 'list', no more arguments expected
      _message 'no additional arguments'
      ;;
  esac
}

_tmplt "$@"