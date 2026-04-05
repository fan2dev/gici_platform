# Domain Model

## Consolidated model baseline

The current schema uses integer primary keys consistently and integer foreign keys across business entities.
Tenant-scoped tables use `organizationId: int`.

## Tenant / platform

- `Organization`
- `OrganizationBranding` (`table: organization_branding`)
- `OrganizationSettings` (`table: organization_settings`)

## Identity / access

- `AppUser`
  - Primary identity for authentication and authorization
  - Contains `email`, `passwordHash`, `role`, `organizationId`, status flags, and audit timestamps
- `AuthSession` (DTO)
  - Returned by auth endpoints with `appUserId`, `organizationId`, `role`, and display identity data

## Education operations

- `Child`
- `ChildProfileOverview` (DTO)
  - Enriched child view with active classroom, guardians list, document/report counts, and last habit timestamp
- `ChildGuardianRelation`
  - Explicit mapping `guardianUserId -> childId` inside organization scope
- `Classroom`
- `ClassroomAssignment`
  - Assignment history is append-only from operations perspective
  - Active assignment state represented via `status` + `withdrawnAt`

## Operations / habits

- `TimeEntry`
  - Append-only event records
  - Correction trail represented with `parentEntryId` and `correctionReason`
  - Attribution represented by `createdByUserId`
- `MealEntry`
- `NapEntry`
- `BowelMovementEntry`
  - Tracks diaper changes and bowel movements with event type and consistency
- `ChildDailyHabits` (DTO)
  - Aggregates meals, naps, and bowel movements for a specific child and day
- `ChildTimelineItem` (DTO)
  - Unified timeline view combining habits, reports, documents, and events

## Communication / media

- `ChatConversation`
  - Uses `conversationType` (`direct`, `group`, etc.)
- `ChatParticipant`
  - Includes `lastReadMessageId` and `lastReadAt`
- `ChatMessage`
  - Uses `senderUserId`, `body`, `messageType`, `deletedAt`
- `FileAsset`
- `OrganizationDocument`
- `ChildDocument`
- `Gallery`
- `GalleryItem`
- `PushDeviceToken`
- `NotificationRecord`

## Experience / center

- `UserOnboardingState`
- `MenuEntry`
- `PedagogicalReport`
  - Child progress reports with visibility controls (guardian/staff)
  - Supports published/draft status and rich content (title, summary, body)
- `DataChangeRequest`
  - Guardian-initiated change requests for child/profile data
  - Staff review workflow with status tracking (pending/approved/rejected)

## Audit

- `ActivityLog`
  - Consistent integer references for `organizationId`, optional `userId`, optional `entityId`

## Conventions

- Enum-like values are currently persisted as `String` by design.
- Soft-delete is kept where operationally needed (`deletedAt`).
- Endpoint pagination is standardized with `page` + `pageSize`.
