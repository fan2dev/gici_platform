BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bowel_movement_entry" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "childId" bigint NOT NULL,
    "recordedByUserId" bigint NOT NULL,
    "eventAt" timestamp without time zone NOT NULL,
    "eventType" text NOT NULL,
    "consistency" text,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "bowel_org_idx" ON "bowel_movement_entry" USING btree ("organizationId");
CREATE INDEX "bowel_child_idx" ON "bowel_movement_entry" USING btree ("childId");
CREATE INDEX "bowel_event_idx" ON "bowel_movement_entry" USING btree ("eventAt");
CREATE INDEX "bowel_child_event_idx" ON "bowel_movement_entry" USING btree ("childId", "eventAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "child_document" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "childId" bigint NOT NULL,
    "fileAssetId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "visibleToGuardians" boolean NOT NULL,
    "createdByUserId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "childdoc_org_idx" ON "child_document" USING btree ("organizationId");
CREATE INDEX "childdoc_child_idx" ON "child_document" USING btree ("childId");
CREATE INDEX "childdoc_file_idx" ON "child_document" USING btree ("fileAssetId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "data_change_request" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "requesterUserId" bigint NOT NULL,
    "targetChildId" bigint,
    "requestType" text NOT NULL,
    "requestPayload" text NOT NULL,
    "status" text NOT NULL,
    "resolutionNote" text,
    "reviewedByUserId" bigint,
    "reviewedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "dcr_org_idx" ON "data_change_request" USING btree ("organizationId");
CREATE INDEX "dcr_requester_idx" ON "data_change_request" USING btree ("requesterUserId");
CREATE INDEX "dcr_target_child_idx" ON "data_change_request" USING btree ("targetChildId");
CREATE INDEX "dcr_status_idx" ON "data_change_request" USING btree ("status");
CREATE INDEX "dcr_created_idx" ON "data_change_request" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "gallery" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "audienceType" text NOT NULL,
    "audienceClassroomId" bigint,
    "audienceChildId" bigint,
    "createdByUserId" bigint NOT NULL,
    "isPublished" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "gallery_org_idx" ON "gallery" USING btree ("organizationId");
CREATE INDEX "gallery_audience_idx" ON "gallery" USING btree ("audienceType");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "gallery_item" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "galleryId" bigint NOT NULL,
    "fileAssetId" bigint NOT NULL,
    "caption" text,
    "sortOrder" bigint NOT NULL,
    "createdByUserId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "galleryitem_org_idx" ON "gallery_item" USING btree ("organizationId");
CREATE INDEX "galleryitem_gallery_idx" ON "gallery_item" USING btree ("galleryId");
CREATE INDEX "galleryitem_sort_idx" ON "gallery_item" USING btree ("galleryId", "sortOrder");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "menu_entry" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "menuDate" timestamp without time zone NOT NULL,
    "mealType" text NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "classroomId" bigint,
    "createdByUserId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "menu_org_idx" ON "menu_entry" USING btree ("organizationId");
CREATE INDEX "menu_date_idx" ON "menu_entry" USING btree ("menuDate");
CREATE INDEX "menu_org_date_idx" ON "menu_entry" USING btree ("organizationId", "menuDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification_record" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "category" text NOT NULL,
    "targetScope" text NOT NULL,
    "targetClassroomId" bigint,
    "targetChildId" bigint,
    "targetUserId" bigint,
    "createdByUserId" bigint NOT NULL,
    "isRead" boolean NOT NULL,
    "readAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notification_org_idx" ON "notification_record" USING btree ("organizationId");
CREATE INDEX "notification_user_idx" ON "notification_record" USING btree ("userId");
CREATE INDEX "notification_created_idx" ON "notification_record" USING btree ("createdAt");
CREATE INDEX "notification_scope_idx" ON "notification_record" USING btree ("targetScope");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization_document" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "fileAssetId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "visibility" text NOT NULL,
    "createdByUserId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "orgdoc_org_idx" ON "organization_document" USING btree ("organizationId");
CREATE INDEX "orgdoc_file_idx" ON "organization_document" USING btree ("fileAssetId");
CREATE INDEX "orgdoc_visibility_idx" ON "organization_document" USING btree ("visibility");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pedagogical_report" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "childId" bigint NOT NULL,
    "reportDate" timestamp without time zone NOT NULL,
    "title" text NOT NULL,
    "summary" text NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "visibility" text NOT NULL,
    "createdByUserId" bigint NOT NULL,
    "updatedByUserId" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "report_org_idx" ON "pedagogical_report" USING btree ("organizationId");
CREATE INDEX "report_child_idx" ON "pedagogical_report" USING btree ("childId");
CREATE INDEX "report_date_idx" ON "pedagogical_report" USING btree ("reportDate");
CREATE INDEX "report_status_idx" ON "pedagogical_report" USING btree ("status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_onboarding_state" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "userId" bigint NOT NULL,
    "introCompletedAt" timestamp without time zone,
    "termsAcceptedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "onboarding_user_idx" ON "user_onboarding_state" USING btree ("userId");
CREATE INDEX "onboarding_org_idx" ON "user_onboarding_state" USING btree ("organizationId");


--
-- MIGRATION VERSION FOR gici_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gici_backend', '20260405180554045-add-missing-tables', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260405180554045-add-missing-tables', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


--
-- MIGRATION VERSION FOR 'gici_backend_server'
--
DELETE FROM "serverpod_migrations"WHERE "module" IN ('gici_backend_server');

COMMIT;
