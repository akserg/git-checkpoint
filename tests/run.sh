#!/usr/bin/env bash
#
# Test runner for git-checkpoint
#
# Discovers and executes all test cases under tests/cases/
# Stops on first failure and reports results.
#

set -euo pipefail

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CASES_DIR="$SCRIPT_DIR/cases"

# Test case execution order (deterministic)
TEST_CASES=(
    "no-command"
    "help"
    "unknown-command"
    "outside-repo"
    "inside-repo"
    "inside-repo-subdir"
)

# ------------------------------------------------------------------------------
# Output formatting
# ------------------------------------------------------------------------------

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# ------------------------------------------------------------------------------
# Main runner
# ------------------------------------------------------------------------------

main() {
    local passed=0
    local failed=0
    
    echo "Running git-checkpoint tests..."
    echo ""
    
    # Change to project root for consistent paths
    cd "$PROJECT_ROOT"
    
    for test_name in "${TEST_CASES[@]}"; do
        local test_script="$CASES_DIR/${test_name}.sh"
        
        if [[ ! -f "$test_script" ]]; then
            print_fail "$test_name (test file not found: $test_script)"
            failed=$((failed + 1))
            echo ""
            echo "Test run aborted."
            exit 1
        fi
        
        # Run test in subshell to isolate failures
        if bash "$test_script"; then
            print_pass "$test_name"
            passed=$((passed + 1))
        else
            print_fail "$test_name"
            failed=$((failed + 1))
            echo ""
            echo "Test run aborted on first failure."
            exit 1
        fi
    done
    
    echo ""
    echo "All tests passed. ($passed/$passed)"
    exit 0
}

main "$@"

