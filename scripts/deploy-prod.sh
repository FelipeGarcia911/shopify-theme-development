#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${ROOT_DIR}/scripts/lib/load-env.sh"

require_var SHOPIFY_FLAG_STORE
require_var SHOPIFY_PROD_THEME_ID

AUTH_ARGS=()
if [[ -n "${SHOPIFY_CLI_THEME_TOKEN:-}" ]]; then
  AUTH_ARGS+=(--password "${SHOPIFY_CLI_THEME_TOKEN}")
fi

if [[ "${CONFIRM_PROD_DEPLOY:-false}" != "true" ]]; then
  echo "Refusing PROD deploy. Set CONFIRM_PROD_DEPLOY=true in your environment to continue." >&2
  exit 1
fi

echo "Deploying to PROD theme ${SHOPIFY_PROD_THEME_ID}"
shopify theme push \
  --store "${SHOPIFY_FLAG_STORE}" \
  "${AUTH_ARGS[@]}" \
  --theme "${SHOPIFY_PROD_THEME_ID}" \
  --path "${ROOT_DIR}" \
  --allow-live
