#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${ROOT_DIR}/scripts/lib/load-env.sh"

require_var SHOPIFY_FLAG_STORE

DEV_ARGS=(
  --store "${SHOPIFY_FLAG_STORE}"
  --path "${ROOT_DIR}"
)

if [[ -n "${SHOPIFY_DEV_THEME_ID:-}" ]]; then
  DEV_ARGS+=(--theme "${SHOPIFY_DEV_THEME_ID}")
fi

echo "Starting Shopify local development server"
shopify theme dev "${DEV_ARGS[@]}"
