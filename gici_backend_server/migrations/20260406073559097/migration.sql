BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "absence" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "organizationId" uuid NOT NULL,
    "childId" uuid NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "reason" text,
    "isJustified" boolean NOT NULL,
    "reportedByUserId" uuid NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "absence_org_idx" ON "absence" USING btree ("organizationId");
CREATE INDEX "absence_child_idx" ON "absence" USING btree ("childId");
CREATE INDEX "absence_date_idx" ON "absence" USING btree ("date");
CREATE UNIQUE INDEX "absence_child_date_idx" ON "absence" USING btree ("childId", "date");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "app_user" ADD COLUMN "dni" text;
ALTER TABLE "app_user" ADD COLUMN "address" text;
ALTER TABLE "app_user" ADD COLUMN "gender" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "child" ADD COLUMN "transportEnabled" boolean;
ALTER TABLE "child" ADD COLUMN "busRoute" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "child_tariff_assignment" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "organizationId" uuid NOT NULL,
    "childId" uuid NOT NULL,
    "tariffId" uuid NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "cta_org_idx" ON "child_tariff_assignment" USING btree ("organizationId");
CREATE INDEX "cta_child_idx" ON "child_tariff_assignment" USING btree ("childId");
CREATE INDEX "cta_tariff_idx" ON "child_tariff_assignment" USING btree ("tariffId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "consent_record" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "organizationId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "childId" uuid,
    "consentType" text NOT NULL,
    "isAccepted" boolean NOT NULL,
    "acceptedAt" timestamp without time zone,
    "ipAddress" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "consent_org_idx" ON "consent_record" USING btree ("organizationId");
CREATE INDEX "consent_user_idx" ON "consent_record" USING btree ("userId");
CREATE INDEX "consent_child_idx" ON "consent_record" USING btree ("childId");
CREATE INDEX "consent_type_idx" ON "consent_record" USING btree ("consentType");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "school_calendar_event" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "organizationId" uuid NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "eventDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone,
    "eventType" text NOT NULL,
    "isRecurring" boolean NOT NULL,
    "createdByUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "cal_org_idx" ON "school_calendar_event" USING btree ("organizationId");
CREATE INDEX "cal_date_idx" ON "school_calendar_event" USING btree ("eventDate");
CREATE INDEX "cal_type_idx" ON "school_calendar_event" USING btree ("eventType");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "staff_classroom_permission" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "organizationId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "classroomId" uuid NOT NULL,
    "role" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "scp_org_idx" ON "staff_classroom_permission" USING btree ("organizationId");
CREATE INDEX "scp_user_idx" ON "staff_classroom_permission" USING btree ("userId");
CREATE INDEX "scp_classroom_idx" ON "staff_classroom_permission" USING btree ("classroomId");
CREATE UNIQUE INDEX "scp_unique" ON "staff_classroom_permission" USING btree ("userId", "classroomId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tariff" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "organizationId" uuid NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "schedule" text NOT NULL,
    "monthlyPrice" double precision NOT NULL,
    "includesTransport" boolean NOT NULL,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "tariff_org_idx" ON "tariff" USING btree ("organizationId");
CREATE INDEX "tariff_active_idx" ON "tariff" USING btree ("isActive");


--
-- MIGRATION VERSION FOR gici_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gici_backend', '20260406073559097', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260406073559097', "timestamp" = now();

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


COMMIT;
