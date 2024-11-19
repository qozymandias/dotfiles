#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 <directory_path> <number_of_characters_to_remove> <begin|end>"
  exit 1
fi

dir_path="$1"
num_chars="$2"
position="$3"

if ! [[ "$num_chars" =~ ^[0-9]+$ ]] || [ "$num_chars" -le 0 ]; then
  echo "Error: <number_of_characters_to_remove> must be a positive integer."
  exit 1
fi

if [[ "$position" != "begin" && "$position" != "end" ]]; then
  echo "Error: <begin|end> must be either 'begin' or 'end'."
  exit 1
fi

for dir in "$dir_path"/*; do
  if [[ -d "$dir" ]]; then
    folder_name=$(basename "$dir")
    folder_length=${#folder_name}

    if [ "$folder_length" -le "$num_chars" ]; then
      echo "Skipping '$folder_name' as it's too short to remove $num_chars characters."
      continue
    fi

    if [[ "$position" == "begin" ]]; then
      new_name="${folder_name:num_chars}"
    else
      new_name="${folder_name:0:folder_length-num_chars}"
    fi

    mv "$dir" "$dir_path/$new_name"
    echo "Renamed '$folder_name' to '$new_name'"
  fi
done
