# Local Development

## Prerequisites

- Dart / Flutter SDK
- PostgreSQL running and configured for Serverpod
- Serverpod CLI

## Backend

```bash
cd gici_backend_server/gici_backend_server_server
dart pub get
serverpod generate
serverpod create-migration
dart bin/main.dart --apply-migrations
```

## Seed demo tenant (El Borreguet)

Call endpoint `bootstrap.seedDemoData` with key:

- `bootstrapKey = local-dev-bootstrap`

## Flutter app (single app for mobile + web)

```bash
cd gici_app
flutter pub get
flutter run -d chrome
# or
flutter run -d ios
# or
flutter run -d android
```
