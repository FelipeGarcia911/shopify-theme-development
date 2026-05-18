# DEV and PROD Workflow

## Branch model

- `main`: production-ready code only
- `develop`: integration branch for validated features
- `feature/*`: implementation branches

## Daily flow

1. Sync develop
2. Create feature branch
3. Implement and test locally (`pnpm run dev`)
4. Run checks (`pnpm run check`)
5. Open PR into develop
6. After merge, deploy to DEV theme and run QA
7. Promote develop changes to main by PR
8. Execute PROD deployment workflow manually with approval

## Promotion model

- DEV deployment is automatic on push to `develop` and can be triggered manually.
- PROD deployment is manual only through GitHub Actions (`workflow_dispatch`).
- PROD deploy requires approval through the `production` environment gate.

## Rules

- Never edit PROD theme directly in Shopify admin.
- Always validate changes in DEV theme first.
- Keep sections/snippets modular and avoid giant files.
- Keep branch history clean and use pull requests for promotions.
