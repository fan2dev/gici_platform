BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "activity_log" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "userId" bigint,
    "action" text NOT NULL,
    "entityType" text,
    "entityId" bigint,
    "oldValues" text,
    "newValues" text,
    "ipAddress" text,
    "userAgent" text,
    "metadata" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "log_org_idx" ON "activity_log" USING btree ("organizationId");
CREATE INDEX "log_user_idx" ON "activity_log" USING btree ("userId");
CREATE INDEX "log_action_idx" ON "activity_log" USING btree ("action");
CREATE INDEX "log_entity_idx" ON "activity_log" USING btree ("entityType", "entityId");
CREATE INDEX "log_created_idx" ON "activity_log" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_user" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "phone" text,
    "avatarUrl" text,
    "role" text NOT NULL,
    "isActive" boolean NOT NULL,
    "emailVerified" boolean NOT NULL,
    "phoneVerified" boolean NOT NULL,
    "lastLoginAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "appuser_email_idx" ON "app_user" USING btree ("email");
CREATE INDEX "appuser_org_idx" ON "app_user" USING btree ("organizationId");
CREATE INDEX "appuser_role_idx" ON "app_user" USING btree ("role");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_conversation" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "title" text,
    "conversationType" text NOT NULL,
    "relatedChildId" bigint,
    "relatedClassroomId" bigint,
    "createdByUserId" bigint NOT NULL,
    "isArchived" boolean NOT NULL,
    "lastMessageAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "conv_org_idx" ON "chat_conversation" USING btree ("organizationId");
CREATE INDEX "conv_type_idx" ON "chat_conversation" USING btree ("conversationType");
CREATE INDEX "conv_child_idx" ON "chat_conversation" USING btree ("relatedChildId");
CREATE INDEX "conv_classroom_idx" ON "chat_conversation" USING btree ("relatedClassroomId");
CREATE INDEX "conv_last_message_idx" ON "chat_conversation" USING btree ("lastMessageAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_message" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "conversationId" bigint NOT NULL,
    "senderUserId" bigint NOT NULL,
    "body" text NOT NULL,
    "messageType" text NOT NULL,
    "metadataJson" text,
    "deletedAt" timestamp without time zone,
    "sentAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "msg_org_idx" ON "chat_message" USING btree ("organizationId");
CREATE INDEX "msg_conversation_idx" ON "chat_message" USING btree ("conversationId");
CREATE INDEX "msg_sender_idx" ON "chat_message" USING btree ("senderUserId");
CREATE INDEX "msg_sent_idx" ON "chat_message" USING btree ("sentAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_participant" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "conversationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL,
    "lastReadMessageId" bigint,
    "lastReadAt" timestamp without time zone,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "cp_org_idx" ON "chat_participant" USING btree ("organizationId");
CREATE INDEX "cp_conversation_idx" ON "chat_participant" USING btree ("conversationId");
CREATE INDEX "cp_user_idx" ON "chat_participant" USING btree ("userId");
CREATE UNIQUE INDEX "cp_unique_participant" ON "chat_participant" USING btree ("conversationId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "child" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "dateOfBirth" timestamp without time zone NOT NULL,
    "gender" text,
    "photoUrl" text,
    "medicalNotes" text,
    "dietaryNotes" text,
    "allergies" text,
    "emergencyContactName" text,
    "emergencyContactPhone" text,
    "enrollmentDate" timestamp without time zone,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "child_org_idx" ON "child" USING btree ("organizationId");
CREATE INDEX "child_status_idx" ON "child" USING btree ("status");
CREATE INDEX "child_name_idx" ON "child" USING btree ("lastName", "firstName");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "child_guardian_relation" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "childId" bigint NOT NULL,
    "guardianUserId" bigint NOT NULL,
    "relation" text NOT NULL,
    "isPrimary" boolean NOT NULL,
    "canPickup" boolean NOT NULL,
    "canViewReports" boolean NOT NULL,
    "canViewPhotos" boolean NOT NULL,
    "emergencyContactOrder" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "cgr_org_idx" ON "child_guardian_relation" USING btree ("organizationId");
CREATE INDEX "cgr_child_idx" ON "child_guardian_relation" USING btree ("childId");
CREATE INDEX "cgr_guardian_idx" ON "child_guardian_relation" USING btree ("guardianUserId");
CREATE UNIQUE INDEX "cgr_unique_relation" ON "child_guardian_relation" USING btree ("childId", "guardianUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "classroom" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "ageGroupMin" bigint,
    "ageGroupMax" bigint,
    "capacity" bigint NOT NULL,
    "color" text,
    "photoUrl" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "classroom_org_idx" ON "classroom" USING btree ("organizationId");
CREATE INDEX "classroom_status_idx" ON "classroom" USING btree ("status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "classroom_assignment" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "classroomId" bigint NOT NULL,
    "childId" bigint NOT NULL,
    "assignedAt" timestamp without time zone NOT NULL,
    "assignedByUserId" bigint,
    "withdrawnAt" timestamp without time zone,
    "withdrawnByUserId" bigint,
    "withdrawnReason" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "ca_org_idx" ON "classroom_assignment" USING btree ("organizationId");
CREATE INDEX "ca_classroom_idx" ON "classroom_assignment" USING btree ("classroomId");
CREATE INDEX "ca_child_idx" ON "classroom_assignment" USING btree ("childId");
CREATE UNIQUE INDEX "ca_unique_active" ON "classroom_assignment" USING btree ("classroomId", "childId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "file_asset" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "uploadedByUserId" bigint NOT NULL,
    "fileName" text NOT NULL,
    "originalName" text NOT NULL,
    "mimeType" text NOT NULL,
    "sizeBytes" bigint NOT NULL,
    "storageProvider" text NOT NULL,
    "storageBucket" text NOT NULL,
    "storagePath" text NOT NULL,
    "publicUrl" text,
    "thumbnailUrl" text,
    "fileType" text NOT NULL,
    "isPublic" boolean NOT NULL,
    "expiresAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "file_org_idx" ON "file_asset" USING btree ("organizationId");
CREATE INDEX "file_type_idx" ON "file_asset" USING btree ("fileType");
CREATE INDEX "file_uploader_idx" ON "file_asset" USING btree ("uploadedByUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_entry" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "childId" bigint NOT NULL,
    "recordedByUserId" bigint NOT NULL,
    "mealType" text NOT NULL,
    "consumptionLevel" text NOT NULL,
    "recordedAt" timestamp without time zone NOT NULL,
    "menuItems" text,
    "notes" text,
    "photoUrl" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "meal_org_idx" ON "meal_entry" USING btree ("organizationId");
CREATE INDEX "meal_child_idx" ON "meal_entry" USING btree ("childId");
CREATE INDEX "meal_date_idx" ON "meal_entry" USING btree ("recordedAt");
CREATE INDEX "meal_child_date_idx" ON "meal_entry" USING btree ("childId", "recordedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "nap_entry" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "childId" bigint NOT NULL,
    "recordedByUserId" bigint NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "endedAt" timestamp without time zone,
    "durationMinutes" bigint,
    "sleepQuality" text,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "nap_org_idx" ON "nap_entry" USING btree ("organizationId");
CREATE INDEX "nap_child_idx" ON "nap_entry" USING btree ("childId");
CREATE INDEX "nap_date_idx" ON "nap_entry" USING btree ("startedAt");
CREATE INDEX "nap_child_date_idx" ON "nap_entry" USING btree ("childId", "startedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "legalName" text,
    "slug" text NOT NULL,
    "contactEmail" text NOT NULL,
    "contactPhone" text,
    "address" text,
    "city" text,
    "postalCode" text,
    "country" text,
    "taxId" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "organization_slug_idx" ON "organization" USING btree ("slug");
CREATE INDEX "organization_status_idx" ON "organization" USING btree ("status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization_branding" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "primaryColor" text,
    "secondaryColor" text,
    "logoUrl" text,
    "logoDarkUrl" text,
    "faviconUrl" text,
    "customCss" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "branding_org_idx" ON "organization_branding" USING btree ("organizationId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization_settings" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "defaultLanguage" text NOT NULL,
    "timezone" text NOT NULL,
    "dateFormat" text NOT NULL,
    "timeFormat" text NOT NULL,
    "workingHoursStart" text NOT NULL,
    "workingHoursEnd" text NOT NULL,
    "maxChildrenPerClassroom" bigint NOT NULL,
    "earlyCheckInMinutes" bigint NOT NULL,
    "lateCheckOutMinutes" bigint NOT NULL,
    "guardianPhotoUploadEnabled" boolean NOT NULL,
    "chatEnabled" boolean NOT NULL,
    "pushNotificationsEnabled" boolean NOT NULL,
    "requireGuardianUploadApproval" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "settings_org_idx" ON "organization_settings" USING btree ("organizationId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "push_device_token" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "token" text NOT NULL,
    "platform" text NOT NULL,
    "deviceId" text,
    "deviceModel" text,
    "appVersion" text,
    "isActive" boolean NOT NULL,
    "lastUsedAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "push_org_idx" ON "push_device_token" USING btree ("organizationId");
CREATE INDEX "push_user_idx" ON "push_device_token" USING btree ("userId");
CREATE UNIQUE INDEX "push_token_idx" ON "push_device_token" USING btree ("token");
CREATE INDEX "push_user_platform_idx" ON "push_device_token" USING btree ("userId", "platform");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "time_entry" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "entryType" text NOT NULL,
    "recordedAt" timestamp without time zone NOT NULL,
    "parentEntryId" bigint,
    "correctionReason" text,
    "locationData" text,
    "deviceInfo" text,
    "notes" text,
    "isManualEntry" boolean NOT NULL,
    "createdByUserId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "time_org_idx" ON "time_entry" USING btree ("organizationId");
CREATE INDEX "time_user_idx" ON "time_entry" USING btree ("userId");
CREATE INDEX "time_date_idx" ON "time_entry" USING btree ("recordedAt");
CREATE INDEX "time_user_date_idx" ON "time_entry" USING btree ("userId", "recordedAt");
CREATE INDEX "time_parent_idx" ON "time_entry" USING btree ("parentEntryId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gici_backend_server
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gici_backend_server', '20260405165401121', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260405165401121', "timestamp" = now();

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
