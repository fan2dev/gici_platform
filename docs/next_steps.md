# Next Steps

## Completed in this milestone

- Habit tracking MVP: meals, naps, bowel movements with daily aggregation (`ChildDailyHabits`)
- Child timeline aggregation combining habits, reports, documents, and events
- Pedagogical reports with guardian visibility controls (list, create, update)
- Data change request workflow (guardian create, staff review with approve/reject)
- Child profile enrichment with classroom, guardians, counters, and quick navigation links
- Role-aware Flutter pages for habits, timeline, reports, and requests

## High priority

1. Move endpoint actor context from request params to authenticated Serverpod session claims/tokens.
2. Add typed enums in `.spy.yaml` where business vocabularies are stable.
3. Add explicit DB constraints for cross-table ownership invariants (child/classroom/chat membership).
4. Implement storage service abstraction + S3 adapter + signed URL flow.
5. Add integration tests for guardian visibility constraints and participant-only chat access.

## Product modules

6. Extend child/classroom UI with richer forms, filtering, and assignment history timeline.
7. Add FCM/APNs provider integration behind the existing notification and device token endpoints.
8. Add chat attachment upload flow and optional realtime delivery.
9. Add time-tracking correction history and organization report/export screens.
10. Extend document and gallery UX with upload picker, filters, and role-scoped visibility controls.
11. Expand onboarding/center/menu UX with richer forms and organization branding settings.

## Quality and delivery

12. Add integration tests for tenant isolation in backend.
13. Add feature tests for role-based routing and session bootstrap in Flutter.
14. Add CI checks for `serverpod generate`, migration drift, `dart analyze`, and `flutter analyze`.
