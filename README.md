# Shopify Theme Development Template

Reusable template for Shopify theme customization projects with a clear DEV/PROD flow, GitHub Actions pipelines, and fast project bootstrap.

## Goal

A simple, professional setup for teams customizing Shopify themes without a complex frontend architecture:

- VSCode
- GitHub
- Shopify CLI
- pnpm
- Node.js LTS
- DEV Theme + PROD Theme
- Basic CI/CD with manual production approval

## Stack

- Node.js: LTS (recommended 22)
- Package manager: pnpm
- CLI: @shopify/cli
- Quality check: shopify theme check

References:

- Shopify CLI for themes: https://shopify.dev/docs/storefronts/themes/tools/cli
- Shopify CLI in CI/CD: https://shopify.dev/docs/storefronts/themes/tools/cli/ci-cd

## Quickstart

1. Create a new repository from this template.
2. Install dependencies and tooling.
3. Configure environment variables.
4. Pull the client theme.
5. Start local development.

```bash
pnpm install
pnpm run setup:tools
cp .env.example .env
pnpm run auth:login
pnpm run theme:pull
pnpm run dev
```

## Environment Variables

Configure local variables in `.env` and repository secrets in GitHub environments.

| Variable                  | Required                  | Scope               | Example                    | Notes                                                   |
| ------------------------- | ------------------------- | ------------------- | -------------------------- | ------------------------------------------------------- |
| `SHOPIFY_FLAG_STORE`      | Yes                       | Local + CI          | `your-store.myshopify.com` | Store domain used by Shopify CLI `--store`.             |
| `SHOPIFY_CLI_THEME_TOKEN` | Yes in CI, optional local | CI + optional local | `shptka_xxx`               | Theme Access password. Use GitHub Secrets in pipelines. |
| `SHOPIFY_DEV_THEME_ID`    | Yes for DEV deploy        | Local + CI DEV      | `123456789`                | Target theme ID for DEV deployment.                     |
| `SHOPIFY_PROD_THEME_ID`   | Yes for PROD deploy       | Local + CI PROD     | `987654321`                | Target theme ID for PROD deployment.                    |
| `SHOPIFY_FLAG_FORCE`      | Optional                  | CI                  | `1`                        | Disables interactive prompts in CI runs.                |
| `CONFIRM_PROD_DEPLOY`     | Yes for local PROD deploy | Local + CI PROD     | `true` / `false`           | Safety gate that blocks accidental production deploys.  |

Create a `.env` file from the example:

```bash
SHOPIFY_FLAG_STORE=your-store.myshopify.com
SHOPIFY_CLI_THEME_TOKEN=shptka_xxxxxxxxxxxxxxxxxxxxx
SHOPIFY_DEV_THEME_ID=123456789
SHOPIFY_PROD_THEME_ID=987654321
SHOPIFY_FLAG_FORCE=1
CONFIRM_PROD_DEPLOY=false
```

Security:

- Never commit `.env` to git.
- Keep production credentials only in GitHub environment secrets.
- Rotate Theme Access passwords regularly.

## Branch Strategy

- `main`: production-ready code
- `develop`: integration and QA branch
- `feature/*`: daily implementation branches

Examples:

- feature/header-redesign
- feature/pdp-rebranding
- feature/mobile-menu

## Daily Workflow

```text
feature/* -> develop -> DEV Theme QA -> main -> PROD deploy (manual approval)
```

### Local Commands

- Pull current client theme:

```bash
pnpm run theme:pull
```

- Start local development:

```bash
pnpm run dev
```

- Run theme checks:

```bash
pnpm run check
```

- Deploy to DEV theme:

```bash
pnpm run deploy:dev
```

- Deploy to PROD theme (local, protected by safety gate):

```bash
CONFIRM_PROD_DEPLOY=true pnpm run deploy:prod
```

## CI/CD

### Included workflows

- `.github/workflows/ci.yml`: quality checks for pull requests into `develop` and `main`.
- `.github/workflows/deploy-dev.yml`: deploys to DEV theme on push to `develop`, plus manual trigger.
- `.github/workflows/deploy-prod.yml`: manual-only deploy to PROD theme, protected by GitHub `production` environment.

### GitHub Secrets

Development environment (`development`):

- `SHOPIFY_FLAG_STORE`
- `SHOPIFY_CLI_THEME_TOKEN`
- `SHOPIFY_DEV_THEME_ID`

Production environment (`production`):

- `SHOPIFY_FLAG_STORE`
- `SHOPIFY_CLI_THEME_TOKEN`
- `SHOPIFY_PROD_THEME_ID`

Set required reviewers on the `production` environment to enforce approval before deployment.

## Important Rules

1. Never edit PROD theme directly.
2. Always work locally through git branches.
3. Always test in DEV theme first.
4. Keep sections/snippets modular.
5. Avoid giant Liquid files.
6. Keep non-theme files out of push/pull operations via `.shopifyignore`.

## Recommended Theme Structure

```text
assets/
blocks/
config/
layout/
locales/
sections/
snippets/
templates/
```

## VSCode Extensions

Recommended in `.vscode/extensions.json`:

- Shopify Liquid
- Theme Check
- Prettier
- ESLint

## Additional Documentation

- `docs/setup.md`
- `docs/workflow-dev-prod.md`
- `docs/cicd.md`
- `docs/git-and-pipelines.md`
