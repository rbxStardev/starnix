#!/run/current-system/sw/bin/zsh

if [[ "$1" == "-g" ]]; then
	group = true
	shift
fi

if [[ $# -ne 2 ]]; then
	echo 'Wrong number of arguments. Usage: ./wsaction.sh [-g] <dispatcher> <workspace>'
	exit 1
fi

active_ws=$(hyprctl activeworkspace -j | jq -r '.id')

if [[ -n "$group" ]]; then
	hyprctl dispatch $1 $((($2 - 1) * 10 + $active_ws % 10))
else
	hyprctl dispatch $1 $((($active_ws - 1) / 10 * 10 + $2))
fi
