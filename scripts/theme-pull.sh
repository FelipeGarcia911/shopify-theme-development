#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${ROOT_DIR}/scripts/lib/load-env.sh"

require_var SHOPIFY_FLAG_STORE

AUTH_ARGS=()
if [[ -n "${SHOPIFY_CLI_THEME_TOKEN:-}" ]]; then
  AUTH_ARGS+=(--password "${SHOPIFY_CLI_THEME_TOKEN}")
fi

echo "Pulling current theme from ${SHOPIFY_FLAG_STORE}"
shopify theme pull \
  --store "${SHOPIFY_FLAG_STORE}" \
  "${AUTH_ARGS[@]}" \
  --path "${ROOT_DIR}"
