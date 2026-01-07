#!/usr/bin/env bash
#
# Test case: inside-repo-subdir
#
# Scenario: Run git-checkpoint status from a nested directory inside a git repo
# Expected: Exit 0, stdout contains "REPO_ROOT:" and "HAS_CONFIG:"
#           REPO_ROOT should match the repo root, not the subdir
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../helpers.sh"

TEMP_REPO="$(create_temp_repo)"
trap "cleanup_temp_dir '$TEMP_REPO'" EXIT

# Resolve symlinks for consistent path comparison (macOS has /var -> /private/var)
TEMP_REPO_RESOLVED="$(cd "$TEMP_REPO" && pwd -P)"

# Create a nested subdirectory
SUBDIR="$(create_subdir "$TEMP_REPO" "src/components")"

SCRIPT_PATH="$(get_script_path)"

# Run from the subdirectory
run_cmd "$SUBDIR" "$SCRIPT_PATH" status

assert_exit_code "$CMD_EXIT" 0
assert_stdout_contains "$CMD_STDOUT" "REPO_ROOT:"
assert_stdout_contains "$CMD_STDOUT" "HAS_CONFIG:"

# Verify REPO_ROOT points to the actual repo root, not the subdir
# Use resolved path to handle symlinks (e.g., /var -> /private/var on macOS)
assert_stdout_contains "$CMD_STDOUT" "REPO_ROOT: $TEMP_REPO_RESOLVED"

