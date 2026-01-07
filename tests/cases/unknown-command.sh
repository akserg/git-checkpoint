#!/usr/bin/env bash
#
# Test case: unknown-command
#
# Scenario: Run git-checkpoint with an unknown command "wat"
# Expected: Exit 2, stderr contains "Unknown command", stdout is empty
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../helpers.sh"

# Run from a temp repo
TEMP_REPO="$(create_temp_repo)"
trap "cleanup_temp_dir '$TEMP_REPO'" EXIT

SCRIPT_PATH="$(get_script_path)"

run_cmd "$TEMP_REPO" "$SCRIPT_PATH" wat

assert_exit_code "$CMD_EXIT" 2
assert_stderr_contains "$CMD_STDERR" "Unknown command"
# stdout should be empty (usage goes to stderr on error)
assert_empty "$CMD_STDOUT" "stdout"

