#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset


#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
NVIM_EXEC=${NVIM_BIN:-nvim}
BUILD_DIR=${BUILD_DIR:-build}

PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
SCRIPT_NAME=$(basename "$0" '.sh')
TEST_DIR="$BUILD_DIR/$SCRIPT_NAME"
MOCK_HOME="$TEST_DIR/mock-home"
LOG_DIR="$TEST_DIR/logs"  # Output log files are intentionally kept for review and are not deleted.

TIME_STAMP=$(date '+%Y%m%d-%H%M%S')
LOG_FILE_BASE_PATH="$LOG_DIR/run-$TIME_STAMP"
LOG_FILE_PATH="$LOG_FILE_BASE_PATH.log"

_COLOR_GREEN="\e[1;32m"
_COLOR_RED="\e[1;31m"
_COLOR_NC="\e[0m"  # No Color


#------------------------------------------------------------------------------
# Test helpers
#------------------------------------------------------------------------------
function setup_test() {
  mkdir -p \
    "$LOG_DIR" \
    "$MOCK_HOME/.config" \
    "$MOCK_HOME/.local/share" \
    "$MOCK_HOME/.local/state" \
    "$MOCK_HOME/.cache"

  ln -fs "$PROJECT_ROOT/home/.config/nvim" \
    "$MOCK_HOME/.config/"
}

function run_nvim() {
  env \
    --ignore-environment \
    "HOME=$MOCK_HOME" \
    "PATH=$PATH" \
    "TERM=$TERM" \
    "$NVIM_EXEC" \
      --headless \
      "${@}"
}

function nvim_demo() {
  env \
    --ignore-environment \
    "HOME=$MOCK_HOME" \
    "PATH=$PATH" \
    "TERM=$TERM" \
    "$NVIM_EXEC" \
      "${@}"
}

function run_test() {
  local _msg=$1; shift
  local _caller_func="${FUNCNAME[1]}"

  # Toggle: if VERBOSE equals "true", then OUTPUT_TARGET is /dev/stdout; otherwise, it's /dev/null.
  local OUTPUT_TARGET
  OUTPUT_TARGET=$([ "${VERBOSE:-false}" = "true" ] && echo /dev/stdout || echo /dev/null)

  printf '• %s ' "$_msg"

  (  # Sub-shell for pipefail/errexit toggling
    set +o pipefail
    {
      log_section "$_msg ($_caller_func())"
      printf "\n===== START OUTPUT (run_test) =====\n"

      set +o errexit
      trap 'echo "Error: Command \"$BASH_COMMAND\" failed at line ${LINENO}"' ERR
      "$@" 2>&1
      local _return_code=$?
      trap - ERR
      set -o errexit

      printf "\n===== END OUTPUT (run_test) =====\n"

      if [ "$_return_code" -eq 0 ]; then
        printf '\nSTATUS - PASSED\n'
      else
        printf '\nSTATUS - FAILED\n'
      fi

      exit $_return_code
    } | tee -a "$LOG_FILE_PATH" > "$OUTPUT_TARGET"

    if [ "${PIPESTATUS[0]}" -eq 0 ]; then
      echo -e "${_COLOR_GREEN}✓${_COLOR_NC}"
    else
      echo -e "${_COLOR_RED}✖${_COLOR_NC}"
      printf '\nFAILED - Review the log file for more information:\n'
      printf '  - %s\n' "$LOG_FILE_PATH"
      exit 1
    fi

    set -o pipefail
  )
}

function assert_empty_capture() {
  local _capture_file="$1"; shift

  printf 'Capturing stdout/stderr to: %s\n' "$_capture_file"
  local _output
  _output="$("${@}" 2>&1)"
  echo "$_output" | tee -a "$_capture_file"

  if [[ -n "$_output" ]]; then

    echo # Add a vertical space
    echo 'Unexpected output in capture (error):'
    echo '--- START CAPTURE OUTPUT ---'
    echo "$_output"
    echo '--- END CAPTURE OUTPUT ---'
    echo # Add a vertical space

    return 1
  fi
}


#------------------------------------------------------------------------------
# Tests
#------------------------------------------------------------------------------
function bootstrap_nvim() {
  run_test \
      "Bootstrapping NeoVim" \
      run_nvim \
        -c 'TSUpdateSync' \
        -c 'lua print("Sleeping for 15 seconds to let the installation stabalize...")' \
        -c 'lua vim.defer_fn(function() vim.cmd[[qall]] end, 15000)'
}

function test_for_startup_error_messages() {
  local _capture_file=$LOG_FILE_BASE_PATH-${FUNCNAME[0]}.log

  run_test \
    "Verifying no error messages at startup" \
    assert_empty_capture \
      "$_capture_file" \
      _test_for_startup_error_messages
}

function _test_for_startup_error_messages() {
  run_nvim \
    -c 'lua vim.cmd[[autocmd VimEnter * if v:errmsg ~=# "" | cq | endif]]' \
    -c 'qall'
}

function test_lazy_install() {
  run_test \
    "Verifying Lazy installation" \
    run_nvim \
      -c 'lua if not pcall(require, "lazy") then vim.cmd("cq") end' \
      -c 'qall'
}

function test_checkhealth() {
  local _capture_file=$LOG_FILE_BASE_PATH-${FUNCNAME[0]}-capture.log

  run_test \
    "Verifying clean checkhealth" \
    assert_empty_capture \
      "$_capture_file" \
      _test_checkhealth
}

function _test_checkhealth() {
  run_nvim \
    -c 'checkhealth' \
    -c 'qall' \
  |& sed \
    -e 's/^Running healthchecks\.\.\.//'
}


#------------------------------------------------------------------------------
# Utility functions
#------------------------------------------------------------------------------
function log_info {
  echo "+ $*"
}

function log_section {
  local _message="+ $*"
  local _spacer
  _spacer="+ $(printf '=%.0s' {1..77})"

  echo
  echo "$_spacer"
  echo "$_message"
  echo "$_spacer"
}

function fail() {
  local _msg="FAILED - $*"

  printf '\n%s\n' "$_msg" >&2
  printf '\n%s\n' "$_msg" >> "$LOG_FILE_PATH"
  exit 1
}

function display_environment() {
  (
    echo "+ Using:"
    echo "+   BUILD_DIR     = $BUILD_DIR"
    echo "+   LOG_DIR       = $LOG_DIR"
    echo "+   LOG_FILE_PATH = $LOG_FILE_PATH"
    echo "+   MOCK_HOME     = $MOCK_HOME"
    echo "+   NVIM_EXEC     = $NVIM_EXEC"
    echo "+   PROJECT_ROOT  = $PROJECT_ROOT"
    echo "+   TEST_DIR      = $TEST_DIR"
    echo "+   TIME_STAMP    = $TIME_STAMP"
    echo "+   PATH          = $PATH"
  ) >> "$LOG_FILE_PATH"
}


#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------
case "${1:-test}" in
  test)
    printf '\nPrimary run log file: %s\n' "$LOG_FILE_PATH"
    printf 'Related log file:     %s\n\n' "${LOG_FILE_BASE_PATH}-*.log"
    printf 'Testing:\n'
    setup_test
    display_environment
    bootstrap_nvim
    test_for_startup_error_messages
    test_lazy_install
    test_checkhealth
    ;;
  nvim)
    shift
    nvim_demo "$@"
    ;;
  *)
    echo "Usage: $0 [test|nvim]"
    exit 1
    ;;
esac

exit 0
