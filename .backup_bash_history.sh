#!/usr/bin/env bash

set -euo pipefail

HISTFILE="${HOME}/.bash_history"
BACKUP_DIR="${HOME}/dev/dotfiles/.bash_history_backups"
STATE_FILE="${BACKUP_DIR}/.last_line_count"

mkdir -p "${BACKUP_DIR}"

# Get current line count
current_lines=$(wc -l < "${HISTFILE}" || echo 0)

# Read previous line count
if [[ -f "${STATE_FILE}" ]]; then
    last_lines=$(cat "${STATE_FILE}")
else
    last_lines=0
fi

# If history shrank (e.g. truncated), reset
if (( current_lines < last_lines )); then
    last_lines=0
fi

# If no new lines, exit
if (( current_lines == last_lines )); then
    exit 0
fi

# Extract new lines
new_lines=$(tail -n +"$((last_lines + 1))" "${HISTFILE}")

# Determine weekly file (ISO week)
week_file=$(date +"%G-W%V")   # e.g. 2026-W14
output_file="${BACKUP_DIR}/history_${week_file}.log"

# Append with timestamp header (optional but useful)
{
    echo "=== $(date '+%Y-%m-%d %H:%M:%S') ==="
    echo "${new_lines}"
    echo
} >> "${output_file}"

# Save new line count
echo "${current_lines}" > "${STATE_FILE}"
