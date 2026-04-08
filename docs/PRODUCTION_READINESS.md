# GICI Platform — Production Readiness Checklist

**Fecha evaluación**: 2026-04-08
**Estado global**: ~60-65% production-ready. Núcleo funcional sólido; faltan hardening, secretos, storage real, push real, tests y CI/CD.

---

## P0 — Bloqueantes absolutos (NO desplegar sin esto)

### 1. Rotar y proteger secretos
- [ ] Rotar contraseña de la DB de OVH (la actual `VLBU8HMFEnA60Xb` está en git history).
- [ ] Borrar `config/passwords.yaml` del repo y añadirlo a `.gitignore`.
- [ ] Cargar passwords vía variables de entorno o secret manager (AWS Secrets Manager / GCP Secret Manager / OVH vault).
- [ ] Rotar cualquier otra credencial que haya podido estar en repo (revisar `git log -p config/`).
- [ ] Generar `SERVERPOD_SERVICE_SECRET` fuerte y único por entorno.

### 2. Corregir `config/production.yaml`
- [ ] Reemplazar `api.examplepod.com`, `insights.examplepod.com`, `app.examplepod.com` por los dominios reales.
- [ ] Activar `redis.enabled: true` y configurar host/credenciales reales.
- [ ] Activar `sessionLogs.persistentEnabled: true` y `consoleEnabled: true` con formato JSON para ingestión en logging.
- [ ] Verificar `database.requireSsl: true` (ya está).
- [ ] Revisar `maxRequestSize` — 512KB es bajo para subida de imágenes; subir a 10-20MB si los uploads pasan por el API (o delegar a S3 presigned, ver P0-4).

### 3. Parametrizar `apiUrl` del cliente Flutter
- [ ] `gici_app/lib/core/config/gici_config.dart` y `borreguet_config.dart`: leer `apiUrl` de `String.fromEnvironment('API_URL', defaultValue: ...)`.
- [ ] Añadir comando de build por entorno: `flutter build web --dart-define=API_URL=https://api.gici.app/`.
- [ ] Documentar en `CLAUDE.md` el comando de build de producción.

### 4. Storage real (S3 / GCS / OVH Object Storage)
- [ ] Crear `ProductionStorageService` implementando `StorageService` con cliente S3-compatible (recomendado OVH Object Storage para latencia EU).
- [ ] Método `resolveDownloadUrl` → generar presigned URL con TTL (15 min).
- [ ] Añadir endpoint `storage.requestUploadUrl` que devuelva presigned PUT URL y registre `FileAsset` en pending.
- [ ] Cambiar UX de upload en Flutter (documents, galleries, organization branding) para usar presigned PUT directo a S3.
- [ ] Bucket por entorno, con bucket policy que bloquea ACL pública; todo acceso vía presigned URLs.
- [ ] Configurar lifecycle: borrar pending uploads >24h sin confirmar.

### 5. Push notifications reales
- [ ] Crear proyecto Firebase (uno por entorno según `docs/environments.md`).
- [ ] Añadir credenciales de servicio FCM al backend vía secret manager.
- [ ] Extender `NotificationService` con método `sendPushToUser(session, userId, title, body, data)` que:
  - busca tokens activos en `PushDeviceToken`
  - envía FCM HTTP v1 (package `http` + JWT firmado) o `firebase_admin` equivalente
  - marca tokens inválidos como `isActive = false` al recibir `UNREGISTERED`
- [ ] Llamar desde: nueva `DataChangeRequest`, nuevo `PedagogicalReport` publicado, nueva entrada en `ChildDailyHabits` (configurable), nuevo mensaje en `ChatConversation`.
- [ ] Integración Flutter: `firebase_messaging` en `main.dart`, pedir permisos, registrar token con `notification.registerDeviceToken`.
- [ ] APNs: subir key `.p8` a Firebase (consola → iOS app).

### 6. Email transaccional
- [ ] Configurar provider SMTP (SendGrid, Mailgun, OVH Exchange) en `production.yaml` y passwords.
- [ ] Implementar `Emails.sendPasswordResetMail` con template HTML branded por tenant (leyendo `OrganizationBranding`).
- [ ] Email templates: welcome, password reset, guardian invitation, data change request decision.
- [ ] Configurar SPF, DKIM y DMARC del dominio remitente.

---

## P1 — Necesario para operar con tranquilidad

### 7. Observabilidad
- [ ] Integrar Sentry (paquete `sentry_dart` + `sentry_flutter`) con DSNs por entorno.
- [ ] Exportar `sessionLogs` de Serverpod Insights hacia el stack de logging (Datadog, Grafana Loki, CloudWatch).
- [ ] Healthcheck endpoint (`/` o `/health`) — verificar que Serverpod expone uno y apuntarlo desde el LB.
- [ ] Métricas básicas: latencia p50/p95/p99, error rate, DB connection pool, request rate por endpoint.
- [ ] Alertas: 5xx >1%, latencia p95 >2s, DB CPU >80%, disk >80%.

### 8. Seguridad / Hardening
- [ ] Punto #1 de `next_steps.md`: eliminar `actorId` como parámetro en endpoints; resolverlo 100% desde `session.authenticated`. Revisar los 19 endpoints.
- [ ] Rate limiting delante del API (Cloudflare, AWS WAF, o nginx/Caddy con `limit_req`).
- [ ] WAF/DDoS (Cloudflare Free basta para empezar).
- [ ] CORS explícito en `production.yaml` solo para el dominio de la webapp.
- [ ] Cabeceras de seguridad en Flutter web build (CSP, HSTS, X-Frame-Options) vía nginx/Caddy o `web/index.html`.
- [ ] Auditar que ningún endpoint devuelve datos de otra `organizationId` — añadir test explícito (ver P1-10).
- [ ] Revisar todas las queries raw (`session.db.unsafeQuery`) — si hay, parametrizar.

### 9. Base de datos
- [ ] Verificar que la DB de OVH tiene backups automáticos (point-in-time recovery idealmente).
- [ ] Documentar el runbook de restore (cuánto se tarda, pasos exactos).
- [ ] Crear índices explícitos en `.spy.yaml` para queries caliente:
  - `(organizationId, childId, date)` en `meal_entry`, `nap_entry`, `bowel_movement_entry`
  - `(organizationId, userId, isRead)` en `notification_record`
  - `(organizationId, createdAt DESC)` en `activity_log`
- [ ] Añadir constraints de DB para invariantes cross-table (punto #3 de `next_steps.md`):
  - `child.classroomId` debe pertenecer a la misma `organizationId` que el child
  - `chat_participant.userId` y `chat_conversation` mismo tenant
- [ ] Job de purga de `deletedAt` > N días (GDPR).

### 10. Tests
- [ ] **Backend — integration tests** con Serverpod test tools:
  - Aislamiento multitenant: un actor de org A no puede leer/escribir datos de org B en cada endpoint de lectura.
  - Autorización: guardian solo ve sus propios `child_ids`; staff solo ve su classroom; org_admin su org; super_admin todo.
  - Chat: solo participantes leen mensajes.
  - Habits: guardian solo ve habits del día actual del niño que le corresponde.
  - Data change requests: guardian crea, staff aprueba, refleja cambio en entity.
- [ ] **Flutter — widget / bloc tests** para cubits críticos: auth, dashboard, habits, chat.
- [ ] **E2E humo**: script que arranca server + DB limpia, corre bootstrap seed, loguea guardian/staff/admin, ejecuta 1 flujo por rol.
- [ ] Coverage objetivo mínimo: backend 50%, cubits 60%.

### 11. CI/CD
- [ ] `.github/workflows/backend.yml`:
  - checkout → `serverpod generate` → `git diff --exit-code` (detecta drift)
  - `dart analyze --fatal-infos`
  - `dart test`
  - build Docker → push a registry (ECR / GCR / GHCR) tagueado con SHA
- [ ] `.github/workflows/app.yml`:
  - `flutter analyze`
  - `flutter test`
  - `flutter build web --dart-define=API_URL=...` por flavor
  - artifact / deploy a hosting (Firebase Hosting, Cloudflare Pages, S3+CloudFront)
- [ ] Auto-deploy a staging en merge a `main`; manual approval para prod.
- [ ] Migraciones: `dart bin/main.dart --apply-migrations --role=maintenance` ejecutado automáticamente pre-deploy con lock.

---

## P2 — GDPR / Legal (España, guardería con menores → crítico pero fuera del deploy técnico)

### 12. Cumplimiento de datos
- [ ] Endpoint `dataRights.exportChildData(childId)` → ZIP con JSON de todas las tablas relacionadas + media URLs (GDPR art. 20).
- [ ] Endpoint `dataRights.requestDeletion(childId)` → workflow de borrado con retención legal configurable.
- [ ] Política de retención: child data purgable X años tras baja; logs de auditoría Y años.
- [ ] Registro de actividades de tratamiento (documento externo, pero referenciarlo).
- [ ] DPA (Data Processing Agreement) firmable entre GICI y cada organización.
- [ ] Consent management: `ConsentRecord` ya existe — asegurar que cubre LOPDGDD (imagen, salud, comunicaciones).
- [ ] Aviso legal, política de privacidad y cookies en la webapp con textos revisados por abogado.
- [ ] Cifrado en reposo de la DB (OVH lo ofrece, confirmar que está activado) y de buckets de storage.
- [ ] Log de accesos a datos sensibles de menores (`ActivityLog` ya existe; verificar cobertura).

### 13. Operación multitenant
- [ ] Proceso documentado de alta de nueva organización (hoy solo `bootstrap.seedDemoData`).
- [ ] Endpoint o script `organization.provision(name, adminEmail, ...)` idempotente.
- [ ] Branding por tenant ya soportado (`OrganizationBranding`) — verificar que Flutter lo lee en runtime por dominio o subdominio.
- [ ] Estrategia de subdominios vs. single domain con selector.

---

## P3 — Mejoras producto antes del piloto

### 14. UX gaps conocidos (de `next_steps.md`)
- [ ] Formularios más ricos en children/classrooms (filtros, assignment history).
- [ ] Chat attachment upload (depende de P0-4 storage).
- [ ] Time tracking: corrección histórica + export para dirección.
- [ ] Documents/galleries: picker real + visibilidad por rol (depende de P0-4).
- [ ] Onboarding de centro + menu: formularios completos y branding.
- [ ] Direccion feature: solo tiene 2 pages y 0 cubits — revisar estado real.
- [ ] Pedagogical reports: 2 pages, 0 cubits — idem.
- [ ] Parent preview: 1 page, 0 cubits — idem.

### 15. Tipado
- [ ] Convertir a `enum` los fields estables (`.spy.yaml` soporta desde Serverpod 2.x): roles, estados de request, tipos de habit, etc. (punto #2 de `next_steps.md`).

---

## Orden de ataque sugerido (ruta crítica a piloto en producción)

**Sprint 1 (3-5 días) — hacer desplegable**
1. P0-1 Secretos (medio día)
2. P0-2 production.yaml (1h)
3. P0-3 apiUrl parametrizado (1h)
4. P1-7 Observabilidad básica: Sentry + healthcheck (medio día)
5. Deploy a staging real, probar con datos seed, validar TLS, validar login.

**Sprint 2 (5-7 días) — hacer usable**
6. P0-4 Storage S3 + presigned URLs (2 días)
7. P0-5 FCM push real (2 días)
8. P0-6 Email transaccional (1 día)
9. P1-9 Backups verificados + runbook (medio día)

**Sprint 3 (5-7 días) — hacer seguro**
10. P1-8 Hardening: actorId desde sesión, rate limiting, CORS, headers (2 días)
11. P1-10 Tests críticos: multitenant + autorización (3 días)
12. P1-11 CI/CD con gates (1 día)

**Sprint 4 (5-10 días) — hacer legal**
13. P2-12 GDPR export/deletion (3 días)
14. P2-13 Provisioning multitenant (1-2 días)
15. P3-14 Cerrar gaps de UX del piloto (variable)

**Total realista a producción con 1 persona full-time: 4-6 semanas.**
Con piloto restringido a El Borreguet (1 tenant), aceptando riesgos controlados: **Sprint 1+2 = 2 semanas**.

---

## Decisiones pendientes de producto

- ¿Cloud: AWS, GCP u OVH? (Ya hay terraform de AWS y GCP; la DB está en OVH → considerar OVH Public Cloud para latencia.)
- ¿Dominio definitivo? (`gici.app`, `gici.es`, subdominios por tenant?)
- ¿Email remitente? (`noreply@gici.app`?)
- ¿Región de storage? (EU-West obligatorio por GDPR.)
- ¿Presupuesto mensual de infra para dimensionar instancias?
