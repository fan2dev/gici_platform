# Assumptions

1. The product uses one Flutter app for both mobile and web (no separate admin web codebase now).
2. El Borreguet is seeded as first tenant, while multitenant isolation is active from day one.
3. Some enum fields are represented as `String` in this first cycle to keep model generation stable.
4. Identity references are consolidated around `AppUser` integer ids; previous provisional dual-id approach was removed before final DB creation.
5. Migration history was intentionally cleaned and rebuilt into a single coherent baseline migration before production DB initialization.
6. Authorization is actor-based (`actorId`) with backend role validation; full signed session token enforcement is planned as next hardening step.
7. File storage is prepared through metadata models; provider integration is the next step.
8. Chat and time tracking are MVP-level operational foundations, not complete final modules.
