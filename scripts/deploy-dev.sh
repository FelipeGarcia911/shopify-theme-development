#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${ROOT_DIR}/scripts/lib/load-env.sh"

require_var SHOPIFY_FLAG_STORE
require_var SHOPIFY_DEV_THEME_ID

AUTH_ARGS=()
if [[ -n "${SHOPIFY_CLI_THEME_TOKEN:-}" ]]; then
  AUTH_ARGS+=(--password "${SHOPIFY_CLI_THEME_TOKEN}")
fi

echo "Deploying current branch to DEV theme ${SHOPIFY_DEV_THEME_ID}"
shopify theme push \
  --store "${SHOPIFY_FLAG_STORE}" \
  "${AUTH_ARGS[@]}" \
  --theme "${SHOPIFY_DEV_THEME_ID}" \
  --path "${ROOT_DIR}"
