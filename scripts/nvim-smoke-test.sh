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
LOG_DIR="$TEST_DIR/logs"

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

  local _capture_file=/dev/null
  if [[ $1 == capture=* ]]; then
    _capture_file=${1#*=}
    shift
  fi

  log_section "$_msg" >> "$LOG_FILE_PATH"
  printf '• %s ' "$_msg"
  if "$@" |& tee -a "$LOG_FILE_PATH" -a "$_capture_file" &> /dev/null; then
    echo -e "${_COLOR_GREEN}✓${_COLOR_NC}"
  else
    echo -e "${_COLOR_RED}✖${_COLOR_NC}"
    exit 1
  fi
}

function bootstrap_nvim() {
  run_test \
      "Bootstrapping NeoVim" \
      run_nvim \
        -c 'TSUpdateSync' \
        -c 'lua print("Sleeping for 15 seconds to let the installation stabalize...")' \
        -c 'lua vim.defer_fn(function() vim.cmd[[qall]] end, 15000)'
}


#------------------------------------------------------------------------------
# Tests
#------------------------------------------------------------------------------
function test_for_startup_error_messages() {
  local _capture_file=$LOG_FILE_BASE_PATH-${FUNCNAME[0]}.log
  run_test \
    "Capturing error messages at startup" \
    "capture=$_capture_file" \
    run_nvim \
      -c 'lua vim.cmd[[autocmd VimEnter * if v:errmsg ~=# "" | cq | endif]]' \
      -c 'qall'

  # TODO - This should likely be folded into the previous command
  run_test \
    "Verifying no error messages at startup" \
    bash -c "[ ! -s '$_capture_file' ]"
}

function test_lazy_install() {
  run_test \
    "Verifying Lazy installation" \
    run_nvim \
      -c 'lua if not pcall(require, "lazy") then vim.cmd("cq") end' \
      -c 'qall'
}

function test_checkhealth() {
  local _capture_file=$LOG_FILE_BASE_PATH-${FUNCNAME[0]}.log
  run_test \
    "Capturing checkhealth" \
    "capture=$_capture_file" \
    run_nvim \
      -c 'checkhealth' \
      -c 'qall'

  # TODO - This is hacky, it should likely be folded into the previous command.
  local _result=/bin/false
  [[ $(sed -e 's/^Running healthchecks\.\.\.//' "$_capture_file" | wc -m) -eq 0 ]] \
    && _result=/bin/true

  run_test \
    "Verifying clean checkhealth" \
    "$_result"
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
echo "Logs are in: $LOG_DIR"

setup_test
display_environment
bootstrap_nvim

test_for_startup_error_messages
test_lazy_install
test_checkhealth

# nvim_demo

exit 0
