# Setup Guide

## Prerequisites

- Node.js LTS (recommended: 22)
- pnpm 10+
- Shopify CLI 3.x
- Access to target Shopify store and theme IDs

## Install tooling

```bash
pnpm install
pnpm run setup:tools
pnpm run shopify:version
```

## Authenticate Shopify CLI (local)

Local authentication options:

- Shopify account login (`shopify auth login`)
- Theme Access password via `SHOPIFY_CLI_THEME_TOKEN`

For CI/CD, use Theme Access passwords stored as secrets.

```bash
pnpm run auth:login
```

## Configure environment

Copy `.env.example` to `.env` and complete values:

- SHOPIFY_FLAG_STORE
- SHOPIFY_CLI_THEME_TOKEN
- SHOPIFY_DEV_THEME_ID
- SHOPIFY_PROD_THEME_ID
- SHOPIFY_FLAG_FORCE (optional, recommended for CI)

## Pull current client theme

```bash
pnpm run theme:pull
```

## Start local development

```bash
pnpm run dev
```

## Validate before pushing

```bash
pnpm run check
pnpm run format:check
pnpm run lint:js
```

## Deploy to DEV theme

```bash
pnpm run deploy:dev
```
