# Architecture Overview

GICI Platform is a multitenant SaaS for childcare centers using one Serverpod backend and one Flutter application that runs on mobile and web.

## Runtime topology

- Backend: `gici_backend_server/gici_backend_server_server` (Serverpod + PostgreSQL)
- Client app: `gici_app` (single Flutter codebase for mobile and web)
- Shared tenant runtime: all business records are organization-scoped via `organizationId` (integer FK)

## Core design choices

- Single Flutter app with role-aware routing and platform-aware entry behavior
- One backend and one database schema, strict tenant filtering per query
- Thin endpoints + service layer for business logic
- Actor-based authorization through `AccessControlService`
- Auditable operations through `ActivityLog`
- Internal chat, time tracking, and child/classroom operational slices enabled
- Content and experience slices enabled: documents, galleries, notifications, onboarding, center info, and menu
- Habit tracking enabled: meals, naps, bowel movements with daily aggregation
- Pedagogical reports enabled with guardian visibility controls
- Data change request workflow enabled for guardian requests and staff review
- Child timeline and enriched profile overview enabled for operational visibility

## Current implementation baseline

- Domain tables generated from `.spy.yaml`
- Seed endpoint for local bootstrap (`bootstrap.seedDemoData`)
- Actor-id based guard pattern in endpoints
- Pagination structure in list endpoints (`page`, `pageSize`)
- Session bootstrap in Flutter via persisted `appUserId` + `auth.me`
- Storage metadata flow enabled through `FileAsset` and document/gallery endpoints
- Notification flow enabled through `NotificationRecord` + `PushDeviceToken`
- Habit tracking endpoints: `habit.listMealsByChild`, `habit.createMealEntry`, `habit.listNapsByChild`, `habit.createNapEntry`, `habit.listBowelMovementsByChild`, `habit.createBowelMovementEntry`, `habit.getChildDailyHabits`
- Child timeline endpoint: `childTimeline.getChildTimeline`
- Pedagogical report endpoints: `pedagogicalReport.listReportsByChild`, `pedagogicalReport.createReport`, `pedagogicalReport.updateReport`
- Data change request endpoints: `dataChangeRequest.createRequest`, `dataChangeRequest.myRequests`, `dataChangeRequest.listRequestsForReview`, `dataChangeRequest.updateRequestStatus`
- Profile overview endpoint: `child.getChildProfileOverview`
