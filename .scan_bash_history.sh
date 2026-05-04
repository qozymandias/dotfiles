#!/usr/bin/env bash

set -euo pipefail

BACKUP_DIR="${1:-${HOME}/dev/dotfiles/.bash_history_backups}"

if [[ ! -d "${BACKUP_DIR}" ]]; then
    echo "Directory not found: ${BACKUP_DIR}" >&2
    exit 1
fi

# Sensitive-data patterns (extended regex / ERE).
PATTERNS=(
    # AWS access key IDs
    '(AKIA|ASIA)[0-9A-Z]{16}'
    # GitHub tokens (ghp_, gho_, ghu_, ghs_, ghr_)
    'gh[pousr]_[A-Za-z0-9]{20,}'
    # Slack tokens
    'xox[abposr]-[A-Za-z0-9-]{10,}'
    # Google API keys
    'AIza[0-9A-Za-z_-]{35}'
    # JWTs (header.payload.signature)
    'eyJ[A-Za-z0-9_-]+\.eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+'
    # PEM private key header
    '-----BEGIN [A-Z ]*PRIVATE KEY-----'
    # URLs with embedded credentials, e.g. https://user:pass@host
    'https?://[^[:space:]/:@]+:[^[:space:]/@]+@[^[:space:]]+'
    # Bearer tokens
    '[Bb]earer[[:space:]]+[A-Za-z0-9._-]{20,}'
    # Generic secret-style assignments: key=value, key: value, etc.
    '(password|passwd|pwd|secret|token|api[_-]?key|access[_-]?key|auth)[[:space:]]*[:=][[:space:]]*[A-Za-z0-9/+=._-]{8,}'
)

# Combine into a single ERE alternation.
combined=""
for p in "${PATTERNS[@]}"; do
    if [[ -z "${combined}" ]]; then
        combined="${p}"
    else
        combined="${combined}|${p}"
    fi
done

prompt_yn() {
    local prompt="$1"
    local reply
    while true; do
        read -r -p "${prompt} [y/N/q] " reply </dev/tty
        case "${reply}" in
            y|Y) return 0 ;;
            q|Q) echo "Quitting."; exit 0 ;;
            ""|n|N) return 1 ;;
        esac
    done
}

# Replace literal `needle` on `lineno` of `file` with [REDACTED] (first occurrence on that line).
redact_line() {
    local file="$1" lineno="$2" needle="$3"
    awk -v ln="${lineno}" -v needle="${needle}" -v repl="[REDACTED]" '
        NR == ln {
            idx = index($0, needle)
            if (idx > 0) {
                $0 = substr($0, 1, idx - 1) repl substr($0, idx + length(needle))
            }
        }
        { print }
    ' "${file}" > "${file}.tmp" && mv "${file}.tmp" "${file}"
}

shopt -s nullglob
files=("${BACKUP_DIR}"/*.log)
if (( ${#files[@]} == 0 )); then
    echo "No .log files in ${BACKUP_DIR}"
    exit 0
fi

total_redacted=0
total_skipped=0

for file in "${files[@]}"; do
    echo
    echo "=== Scanning: ${file} ==="

    matches=$(grep -nEo "${combined}" "${file}" || true)
    if [[ -z "${matches}" ]]; then
        echo "  no matches"
        continue
    fi

    while IFS= read -r entry; do
        lineno="${entry%%:*}"
        match="${entry#*:}"
        context=$(sed -n "${lineno}p" "${file}")

        echo
        echo "  File   : ${file}"
        echo "  Line   : ${lineno}"
        echo "  Match  : ${match}"
        echo "  Context: ${context}"

        if prompt_yn "  Redact this match?"; then
            redact_line "${file}" "${lineno}" "${match}"
            total_redacted=$((total_redacted + 1))
            echo "  -> redacted"
        else
            total_skipped=$((total_skipped + 1))
            echo "  -> skipped"
        fi
    done <<< "${matches}"
done

echo
echo "Done. Redacted: ${total_redacted}, Skipped: ${total_skipped}"
