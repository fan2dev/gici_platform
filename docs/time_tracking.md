# Time Tracking Module

## Scope

Operational staff time tracking with mobile-first check-in/check-out and auditability.

## Current implementation

- Model: `TimeEntry`
  - append-only events
  - correction linkage through `parentEntryId`
  - immutable correction reason through `correctionReason`
  - attribution through `createdByUserId`
- Endpoints:
  - `checkIn`
  - `checkOut`
  - `myEntries`
  - `listEntries` (organization-level view, role restricted)
  - `getEntry`
  - `correctEntry`

## Access rules

- `guardian`: no time-tracking access.
- `staff`: own entries.
- `organization_admin` and `platform_super_admin`: organization overview + corrections.

## Audit behavior

- Check-in and check-out actions are logged to `ActivityLog`.
- Corrections create new `TimeEntry` rows (no overwrite of original entries).
- Correction operations are logged with source and reason metadata.

## Current Flutter implementation

- Personal time tracking page:
  - check-in/check-out actions
  - personal entries listing
- Role guards block guardian access.

## Remaining enhancements

- Add explicit correction history visualization in Flutter.
- Add CSV/export-friendly endpoint payload for payroll integration.
- Add optional location/device integrity metadata capture in mobile flows.
