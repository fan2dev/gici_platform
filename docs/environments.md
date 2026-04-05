# Environments

## Defined environments

- Development
- Staging
- Production

## Backend configuration

Serverpod uses:

- `config/development.yaml`
- `config/staging.yaml`
- `config/production.yaml`

## Environment concerns

- API base URL
- database connection
- Firebase setup
- storage credentials and buckets
- feature flags

## Recommendation

Use one Firebase project per environment, not per organization, and segment recipients in backend logic.
