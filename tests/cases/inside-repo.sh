#!/usr/bin/env bash
#
# Test case: inside-repo
#
# Scenario: Run git-checkpoint status from the root of a git repo
# Expected: Exit 0, stdout contains "REPO_ROOT:" and "HAS_CONFIG:"
# Also tests config detection toggle
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../helpers.sh"

TEMP_REPO="$(create_temp_repo)"
trap "cleanup_temp_dir '$TEMP_REPO'" EXIT

SCRIPT_PATH="$(get_script_path)"

# Test 1: Without config file
run_cmd "$TEMP_REPO" "$SCRIPT_PATH" status

assert_exit_code "$CMD_EXIT" 0
assert_stdout_contains "$CMD_STDOUT" "REPO_ROOT:"
assert_stdout_contains "$CMD_STDOUT" "HAS_CONFIG:"
assert_stdout_contains "$CMD_STDOUT" "HAS_CONFIG: false"

# Test 2: Create config file and verify HAS_CONFIG changes
touch "$TEMP_REPO/.git-checkpoint.yaml"

run_cmd "$TEMP_REPO" "$SCRIPT_PATH" status

assert_exit_code "$CMD_EXIT" 0
assert_stdout_contains "$CMD_STDOUT" "HAS_CONFIG: true"

