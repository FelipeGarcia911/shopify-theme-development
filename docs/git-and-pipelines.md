# Git and Pipelines Setup

## 1. Create repository and default branches

1. Create a new GitHub repository from this template.
2. Ensure `main` and `develop` branches exist.
3. Set `main` as the default branch.

## 2. Branch protection rules

Set protections for both `main` and `develop`:

- Require pull request before merging.
- Require at least one approval.
- Require status checks to pass.
- Restrict direct pushes.

Recommended required check:

- `CI / quality`

## 3. Configure GitHub environments

Create these environments:

- `development`
- `production`

For `production`, require reviewers before deployment.

## 4. Configure environment secrets

### Development environment

- `SHOPIFY_FLAG_STORE`
- `SHOPIFY_CLI_THEME_TOKEN`
- `SHOPIFY_DEV_THEME_ID`

### Production environment

- `SHOPIFY_FLAG_STORE`
- `SHOPIFY_CLI_THEME_TOKEN`
- `SHOPIFY_PROD_THEME_ID`

## 5. Pipeline behavior

- `deploy-dev.yml`:
  - Runs on push to `develop`.
  - Can also run manually via `workflow_dispatch`.
  - Pushes to the DEV theme.

- `deploy-prod.yml`:
  - Manual only (`workflow_dispatch`).
  - Uses the `production` environment gate.
  - Requires approval if reviewers are configured.

## 6. First dry run checklist

1. Open a feature branch and merge into `develop`.
2. Confirm CI and DEV deploy workflow succeed.
3. Validate the DEV theme in Shopify admin.
4. Open PR from `develop` to `main`.
5. Trigger PROD deploy manually and complete approval.
6. Validate PROD theme after deployment.

## 7. Local Git setup

Recommended once per machine:

```bash
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global fetch.prune true
```

Optional commit identity setup:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```
