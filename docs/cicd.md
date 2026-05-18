# CI/CD Guide

## Workflows

- CI: `.github/workflows/ci.yml`
  - Runs on PR to develop/main.
  - Installs dependencies and runs `pnpm run check`.

- DEV deploy: `.github/workflows/deploy-dev.yml`
  - Runs on push to develop and manual trigger.
  - Deploys to DEV theme.

- PROD deploy: `.github/workflows/deploy-prod.yml`
  - Manual only (`workflow_dispatch`).
  - Uses GitHub Environment `production` for approval gate.

## Required GitHub Secrets

Set these secrets in the corresponding environment:

- SHOPIFY_FLAG_STORE
- SHOPIFY_CLI_THEME_TOKEN
- SHOPIFY_DEV_THEME_ID
- SHOPIFY_PROD_THEME_ID

## Environment-specific mapping

- `development` environment:
  - `SHOPIFY_FLAG_STORE`
  - `SHOPIFY_CLI_THEME_TOKEN`
  - `SHOPIFY_DEV_THEME_ID`

- `production` environment:
  - `SHOPIFY_FLAG_STORE`
  - `SHOPIFY_CLI_THEME_TOKEN`
  - `SHOPIFY_PROD_THEME_ID`

The deploy workflows set `SHOPIFY_FLAG_FORCE=1` to disable interactive prompts in CI.

## Recommended environment setup

- development environment:
  - DEV secrets
- production environment:
  - PROD secrets
  - required reviewers enabled

## Security notes

- Do not expose tokens in logs.
- Scope tokens with minimal permissions.
- Protect main and develop with pull request requirements.

## References

- Shopify CLI for themes: https://shopify.dev/docs/storefronts/themes/tools/cli
- Shopify CLI in CI/CD: https://shopify.dev/docs/storefronts/themes/tools/cli/ci-cd
- Theme Access: https://shopify.dev/docs/storefronts/themes/tools/theme-access
