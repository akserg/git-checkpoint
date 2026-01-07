#!/usr/bin/env bash
#
# Test case: outside-repo
#
# Scenario: Run git-checkpoint status from a non-git directory
# Expected: Exit 2, stderr contains "Not a git repository"
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../helpers.sh"

# Create a temp directory that is NOT a git repo
TEMP_DIR="$(mktemp -d)"
trap "cleanup_temp_dir '$TEMP_DIR'" EXIT

SCRIPT_PATH="$(get_script_path)"

run_cmd "$TEMP_DIR" "$SCRIPT_PATH" status

assert_exit_code "$CMD_EXIT" 2
assert_stderr_contains "$CMD_STDERR" "Not a git repository"

