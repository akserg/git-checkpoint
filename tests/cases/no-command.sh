#!/usr/bin/env bash
#
# Test case: no-command
#
# Scenario: Run git-checkpoint with no arguments
# Expected: Exit 0, stdout contains "Usage:", stderr is empty
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../helpers.sh"

# Run from a temp repo (need to be in a valid context)
TEMP_REPO="$(create_temp_repo)"
trap "cleanup_temp_dir '$TEMP_REPO'" EXIT

SCRIPT_PATH="$(get_script_path)"

run_cmd "$TEMP_REPO" "$SCRIPT_PATH"

assert_exit_code "$CMD_EXIT" 0
assert_stdout_contains "$CMD_STDOUT" "Usage:"
assert_empty "$CMD_STDERR" "stderr"

