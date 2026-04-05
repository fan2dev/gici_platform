# Auth and Permissions

## Authentication

- Login endpoint: `auth.signInWithEmailPassword(email, password)`
- Session hydration endpoint: `auth.me(appUserId)`
- Credential source: `AppUser.email` + `AppUser.passwordHash`
- Session payload: `AuthSession` (`appUserId`, `organizationId`, `role`, identity display fields)

## Backend authorization

- Authorization is actor-based, not client role-string based.
- Endpoints receive `actorId` and validate actor identity and role through `AccessControlService`.
- `AccessControlService.requireActor(...)` enforces:
  - actor exists and is active
  - role belongs to endpoint allowed roles
  - actor belongs to requested organization unless role is `platform_super_admin`

## Tenant and role rules implemented

- `platform_super_admin`: cross-tenant administrative scope
- `organization_admin`: full organization operational scope
- `staff`: organization operational scope
- `guardian`: constrained scope to linked children and participant-only conversations

## Flutter session guards

- Session is persisted by `AuthSessionStorage` (stores `appUserId`).
- `AuthCubit.bootstrap()` calls `auth.me` at app startup.
- Router blocks unauthenticated routes.
- Router blocks `guardian` access to restricted operational routes (`time-tracking`, `classrooms`).

## Security notes

- Passwords are hashed server-side before storage.
- Endpoints do not trust client-provided role claims.
- Child and chat access include guardian-specific checks.
