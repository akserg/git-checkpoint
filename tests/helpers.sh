#!/usr/bin/env bash
#
# Test helper library for git-checkpoint tests
#
# Provides assertion functions, temp repo creation, and command execution helpers.
#

# ------------------------------------------------------------------------------
# Globals for command output capture
# ------------------------------------------------------------------------------

CMD_STDOUT=""
CMD_STDERR=""
CMD_EXIT=0

# ------------------------------------------------------------------------------
# Error handling
# ------------------------------------------------------------------------------

# Print error message to stderr and exit with non-zero code
# Usage: fail "error message"
fail() {
    echo "FAIL: $*" >&2
    exit 1
}

# ------------------------------------------------------------------------------
# Assertions
# ------------------------------------------------------------------------------

# Assert that actual exit code matches expected
# Usage: assert_exit_code <actual> <expected>
assert_exit_code() {
    local actual="$1"
    local expected="$2"
    if [[ "$actual" -ne "$expected" ]]; then
        fail "Expected exit code $expected, got $actual"
    fi
}

# Assert that stdout contains a substring
# Usage: assert_stdout_contains <output> <substring>
assert_stdout_contains() {
    local output="$1"
    local substring="$2"
    if [[ "$output" != *"$substring"* ]]; then
        fail "Expected stdout to contain '$substring', got: $output"
    fi
}

# Assert that stderr contains a substring
# Usage: assert_stderr_contains <output> <substring>
assert_stderr_contains() {
    local output="$1"
    local substring="$2"
    if [[ "$output" != *"$substring"* ]]; then
        fail "Expected stderr to contain '$substring', got: $output"
    fi
}

# Assert that output is empty (or whitespace only)
# Usage: assert_empty <output> <description>
assert_empty() {
    local output="$1"
    local description="${2:-output}"
    local trimmed
    trimmed="$(echo -n "$output" | tr -d '[:space:]')"
    if [[ -n "$trimmed" ]]; then
        fail "Expected $description to be empty, got: $output"
    fi
}

# Assert that output is NOT empty
# Usage: assert_not_empty <output> <description>
assert_not_empty() {
    local output="$1"
    local description="${2:-output}"
    local trimmed
    trimmed="$(echo -n "$output" | tr -d '[:space:]')"
    if [[ -z "$trimmed" ]]; then
        fail "Expected $description to be non-empty"
    fi
}

# ------------------------------------------------------------------------------
# Temp repository management
# ------------------------------------------------------------------------------

# Create a temporary git repository with an initial commit
# Echoes the path to the repo
# Usage: repo_path=$(create_temp_repo)
create_temp_repo() {
    local temp_dir
    temp_dir="$(mktemp -d)"
    
    (
        cd "$temp_dir"
        git init --quiet
        git config user.email "test@example.com"
        git config user.name "Test User"
        echo "initial" > README.md
        git add README.md
        git commit --quiet -m "Initial commit"
    ) >/dev/null 2>&1
    
    echo "$temp_dir"
}

# Create a subdirectory in a temp repo
# Usage: create_subdir <repo_path> <subdir_name>
create_subdir() {
    local repo_path="$1"
    local subdir_name="$2"
    mkdir -p "$repo_path/$subdir_name"
    echo "$repo_path/$subdir_name"
}

# Clean up a temporary directory
# Usage: cleanup_temp_dir <path>
cleanup_temp_dir() {
    local path="$1"
    if [[ -d "$path" && "$path" == /tmp/* ]]; then
        rm -rf "$path"
    fi
}

# ------------------------------------------------------------------------------
# Command execution
# ------------------------------------------------------------------------------

# Run a command in a specific directory and capture output
# Sets: CMD_STDOUT, CMD_STDERR, CMD_EXIT
# Usage: run_cmd <working_dir> <command...>
run_cmd() {
    local working_dir="$1"
    shift
    
    local stdout_file
    local stderr_file
    stdout_file="$(mktemp)"
    stderr_file="$(mktemp)"
    
    # Run command, capturing output
    set +e
    (cd "$working_dir" && "$@") >"$stdout_file" 2>"$stderr_file"
    CMD_EXIT=$?
    set -e
    
    CMD_STDOUT="$(cat "$stdout_file")"
    CMD_STDERR="$(cat "$stderr_file")"
    
    rm -f "$stdout_file" "$stderr_file"
}

# ------------------------------------------------------------------------------
# Path helpers
# ------------------------------------------------------------------------------

# Get the absolute path to the repository root (where tests are run from)
# Usage: get_project_root
get_project_root() {
    # This assumes tests are run from the project root
    pwd
}

# Get the path to the git-checkpoint script
# Usage: get_script_path
get_script_path() {
    echo "$(get_project_root)/scripts/git-checkpoint"
}

