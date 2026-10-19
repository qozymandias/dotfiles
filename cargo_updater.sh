#!/usr/bin/env bash
set -euo pipefail

# Ensure cargo-edit is installed
if ! command -v cargo-upgrade &>/dev/null; then
    echo "Installing cargo-edit..." >&2
    cargo install cargo-edit
fi

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <crate1> [crate2 ...]" >&2
    exit 1
fi

file="Cargo.toml"

set -x

# Update each crate in sequence
for crate in "$@"; do
    echo "=> Fetching latest version for $crate..."

    # Query crates.io and extract latest semver tag
    latest=$(cargo search "$crate" --registry ocr-labs | grep -w "^$crate" | awk '{print $3}' | tr -d '"')

    echo "$latest"

    if [ -z "$latest" ]; then
        echo "Could not find version for $crate — skipping." >&2
        continue
    fi

    echo "=> Updating $crate to $latest ..."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "/$crate/ s/version = \"[^\"]*\"/version = \"$latest\"/" "$file"
    else
        sed -i "/$crate/ s/version = \"[^\"]*\"/version = \"$latest\"/" "$file"
    fi

    # cargo update -p "$crate" --precise "$latest"

    # echo "=> Updated $crate to $latest"
    echo
done

# for crate in "$@"; do
#     echo "=> Fetching latest version for $crate..."
# 
#     # Query crates.io and extract latest semver tag
#     latest=$(cargo search "$crate" --registry ocr-labs | grep -w "^$crate" | awk '{print $3}' | tr -d '"')
# 
#     cargo update -p "$crate@$latest" --precise "$latest"
# 
#     echo "=> Updated $crate to $latest"
#     echo
# done
# 
# 
# # Final verification
# # echo "Running cargo check..."
# # cargo check
# 
# echo "All specified crates updated successfully."
