#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo "Script is in: $SCRIPT_DIR"
if [[ -f $SCRIPT_DIR/.fzf_project ]]; then
    file=$SCRIPT_DIR/.fzf_project
    echo "Found .fzf_project at: $file"
else
    echo "Can’t find .fzf_project!"
    exit 1
fi

directories=()
while IFS= read -r line; do
    if [[ ${line:0:2} == "~/" ]]; then
        dir="${HOME}${line:1}"
    else
        dir="$line"
    fi
    if [[ -d $dir ]]; then
        directories+=("$dir")
    fi
done <"$file"

if [[ ${#directories[@]} -eq 0 ]]; then
    echo "No directories found."
    exit 1
fi

echo "Searching these directories: ${directories[@]}"
selected=$(find "${directories[@]}" -mindepth 1 -maxdepth 1 -type d | fzf)
echo "You picked: $selected"
