#!/usr/bin/env bash
# Run only on synthetic fixtures; do not scan arbitrary paths.
set -Eeuo pipefail
: "${WORK_DIR:?Set WORK_DIR to an existing writable directory}"
[[ -d "$WORK_DIR" && -w "$WORK_DIR" ]] || { echo "WORK_DIR is not writable" >&2; exit 2; }
command -v yara >/dev/null || { echo "yara executable is missing" >&2; exit 2; }
command -v yarac >/dev/null || { echo "yarac executable is missing" >&2; exit 2; }
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
case_dir="$(mktemp -d "$WORK_DIR/yara-synthetic.XXXXXXXX")"
rule="$repo/rules/synthetic_marker.yar"
yarac "$rule" "$case_dir/synthetic_marker.yarc"
yara "$rule" "$repo/tests/fixtures/positive.txt" > "$case_dir/positive-results.txt"
yara "$rule" "$repo/tests/fixtures/negative.txt" > "$case_dir/negative-results.txt"
grep -Fq "Synthetic_Linux_Lab_Marker" "$case_dir/positive-results.txt" || {
    echo "Positive fixture was not detected" >&2; exit 1;
}
if [[ -s "$case_dir/negative-results.txt" ]]; then
    echo "Negative fixture unexpectedly matched" >&2; exit 1
fi
sha256sum "$rule" "$repo/tests/fixtures/positive.txt" "$repo/tests/fixtures/negative.txt"     > "$case_dir/source-sha256.txt"
printf '%s\n' "PASS: positive fixture matched and negative fixture did not."     "Logs and hashes: $case_dir"
