# Multitenancy Strategy

## Goal

Keep one backend and one shared schema while enforcing strict data isolation per organization.

## Isolation pattern

- Business entities carry `organizationId`.
- Endpoints require `organizationId` and `actorId` inputs.
- Query filters always include `organizationId` for tenant-scoped resources.

## Role scope

- `platform_super_admin`: platform-level operations (cross-tenant admin operations)
- `organization_admin`: organization-scoped operations
- `staff`: organization-scoped operational access
- `guardian`: restricted read/write access according to guardian context

## Current guard implementation

- `AccessControlService.requireActor(...)` validates actor identity, active status, role eligibility, and organization ownership.
- `parseOrganizationId(...)` and `parseActorId(...)` validate integer identifier format.
- Guardian constraints are explicitly enforced in child and chat scopes.

## Next hardening tasks

- Derive actor identity from authenticated session tokens instead of request payload.
- Add DB-level ownership constraints and automated tenant-isolation tests.
- Add DB-level RLS feasibility assessment for defense-in-depth.
