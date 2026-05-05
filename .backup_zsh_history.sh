#!/usr/bin/env zsh

set -euo pipefail

HISTFILE="${HOME}/.zsh_history"
BACKUP_DIR="${HOME}/dev/dotfiles/.zsh_history_backups"
STATE_FILE="${BACKUP_DIR}/.last_line_count"

mkdir -p "${BACKUP_DIR}"

current_lines=$(wc -l < "${HISTFILE}" || echo 0)

if [[ -f "${STATE_FILE}" ]]; then
    last_lines=$(cat "${STATE_FILE}")
else
    last_lines=0
fi

if (( current_lines < last_lines )); then
    last_lines=0
fi

if (( current_lines == last_lines )); then
    exit 0
fi

new_lines=$(tail -n +"$((last_lines + 1))" "${HISTFILE}")

# Determine weekly file (ISO week)
week_file=$(date +"%G-W%V")
output_file="${BACKUP_DIR}/history_${week_file}.log"

{
    echo "=== $(date '+%Y-%m-%d %H:%M:%S') ==="
    echo "${new_lines}"
    echo
} >> "${output_file}"

echo "${current_lines}" > "${STATE_FILE}"
