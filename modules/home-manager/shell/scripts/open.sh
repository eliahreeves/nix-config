exp() {
	local target="${1:-.}"

	if [[ ! -e "$target" ]]; then
		echo "Error: '$target' does not exist."
		return 1
	fi

	if [[ -f "$target" ]]; then
		target=$(dirname "$target")
	fi

		xdg-open "$target" >/dev/null 2>&1 &|
}

compdef '_files' open
