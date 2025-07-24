#!/usr/bin/env bash
set -euo pipefail

# avoid unbound-variable errors by providing safe defaults
CHECKOUT_CODE="${CHECKOUT_CODE:-false}"
DEBUG_FLAG="${DEBUG_FLAG:-false}"
PATH_INPUT="${PATH_INPUT:-}"
MM_KEY="${MM_KEY:-}"
DOCKER_TAG="${DOCKER_TAG:-v0.7.9}"
MAX_ISSUE_COUNT="${MAX_ISSUE_COUNT:-0}"
MAX_ISSUE_PRIORITY="${MAX_ISSUE_PRIORITY:-0}"

echo "::group::Sanity-checking inputs"

echo "CHECKOUT_CODE      = '${CHECKOUT_CODE}'"
echo "DEBUG_FLAG         = '${DEBUG_FLAG}'"
echo "DOCKER_TAG         = '${DOCKER_TAG}'"
echo "MAX_ISSUE_COUNT    = '${MAX_ISSUE_COUNT}'"
echo "MAX_ISSUE_PRIORITY = '${MAX_ISSUE_PRIORITY}'"
if [[ -n "${PATH_INPUT}" ]]; then
  echo "PATH_INPUT         = '${PATH_INPUT}'"
fi

# Validate API key only if provided
if [[ -n "${MM_KEY}" ]]; then
  if [[ ! "${MM_KEY}" =~ ^[A-Za-z0-9]{4}(-[A-Za-z0-9]{4}){3}$ ]]; then
    echo "::error ::MM_KEY must match format abcd-efgh-ijkl-mnop (4 groups of 4 alphanumeric characters)"
    exit 1
  fi
fi

# Validate booleans
for var_name in CHECKOUT_CODE DEBUG_FLAG; do
  val="${!var_name}"
  if [[ "$val" != "true" && "$val" != "false" ]]; then
    echo "::error ::Invalid $var_name: expected 'true' or 'false', got '$val'"
    exit 1
  fi
done

# If a path was provided, validate it
if [[ -n "${PATH_INPUT}" ]]; then
  if [[ ! -d "${PATH_INPUT}" ]]; then
    echo "::error ::Path '${PATH_INPUT}' does not exist or is not a directory"
    exit 1
  fi
  if ! git -C "${PATH_INPUT}" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "::error ::Path '${PATH_INPUT}' is not a valid git repository"
    exit 1
  fi
fi

# Validate max-issue-count
if [[ ! "${MAX_ISSUE_COUNT}" =~ ^[0-9]+$ ]]; then
  echo "::error ::Invalid MAX_ISSUE_COUNT: expected non-negative integer, got '${MAX_ISSUE_COUNT}'"
  exit 1
fi

# Validate max-issue-priority
if [[ ! "${MAX_ISSUE_PRIORITY}" =~ ^([0-4]|Low|Medium|High|Critical)$ ]]; then
  echo "::error ::Invalid MAX_ISSUE_PRIORITY: expected 0-4 or Low|Medium|High|Critical, got '${MAX_ISSUE_PRIORITY}'"
  exit 1
fi

# Validate that the Docker image tag exists remotely
if ! docker manifest inspect "merlyai/mentor:${DOCKER_TAG}" > /dev/null 2>&1; then
  echo "::error ::Docker image 'merlyai/mentor:${DOCKER_TAG}' not found"
  exit 1
fi

echo "✔ All inputs look sane"
echo "::endgroup::"
