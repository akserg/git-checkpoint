#!/usr/bin/env bash
#
# Test case: help
#
# Scenario: Run git-checkpoint help
# Expected: Exit 0, stdout contains "Commands:" and "checkpoint", stderr is empty
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../helpers.sh"

# Run from a temp repo
TEMP_REPO="$(create_temp_repo)"
trap "cleanup_temp_dir '$TEMP_REPO'" EXIT

SCRIPT_PATH="$(get_script_path)"

run_cmd "$TEMP_REPO" "$SCRIPT_PATH" help

assert_exit_code "$CMD_EXIT" 0
assert_stdout_contains "$CMD_STDOUT" "Commands:"
assert_stdout_contains "$CMD_STDOUT" "checkpoint"
assert_empty "$CMD_STDERR" "stderr"

