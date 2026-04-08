BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "menu_entry" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "menu_entry" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "organizationId" uuid NOT NULL,
    "menuDate" timestamp without time zone NOT NULL,
    "menuTrack" text NOT NULL,
    "mealType" text NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "createdByUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "menu_org_idx" ON "menu_entry" USING btree ("organizationId");
CREATE INDEX "menu_date_idx" ON "menu_entry" USING btree ("menuDate");
CREATE INDEX "menu_org_date_idx" ON "menu_entry" USING btree ("organizationId", "menuDate");
CREATE INDEX "menu_track_idx" ON "menu_entry" USING btree ("menuTrack");


--
-- MIGRATION VERSION FOR gici_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gici_backend', '20260407002757136', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260407002757136', "timestamp" = now();

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
