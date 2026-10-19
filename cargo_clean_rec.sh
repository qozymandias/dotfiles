#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"

find "$ROOT" -type f -name "Cargo.toml" -not -path "*/target/*" -print0 |
while IFS= read -r -d '' file; do
    dir="$(dirname "$file")"
    echo "Cleaning $dir"
    (cd "$dir" && cargo clean)
done

