#!/bin/bash

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${ACCESS_TOKEN}"

REPO_URL=${REPO_URL:-${URI}}
_PROTO="$(echo "${REPO_URL}" | grep :// | sed -e's,^\(.*://\).*,\1,g')"
# shellcheck disable=SC2116
_URL="$(echo "${REPO_URL/${_PROTO}/}")"
_PATH="$(echo "${_URL}" | grep / | cut -d/ -f2-)"
_ACCOUNT="$(echo "${_PATH}" | cut -d/ -f1)"
_REPO="$(echo "${_PATH}" | cut -d/ -f2)"

_FULL_URL="${URI}/repos/${_ACCOUNT}/${_REPO}/actions/runners/registration-token"

_SHORT_URL=$REPO_URL

RUNNER_TOKEN="$(curl -XPOST -fsSL \
  -H "${AUTH_HEADER}" \
  -H "${API_HEADER}" \
  "${_FULL_URL}" |
  jq -r '.token')"

echo "{\"token\": \"${RUNNER_TOKEN}\", \"short_url\": \"${_SHORT_URL}\", \"full_url\": \"${_FULL_URL}\"}"
