# Storage Strategy

## Principles

- Business files must be stored in S3-compatible object storage.
- Local server disk is not the primary business storage layer.
- Database stores file metadata and authorization context.

## Current foundation

- `FileAsset` model stores metadata:
  - provider
  - bucket
  - path
  - mime type
  - size
  - tenant context

## File access design

- Upload/download operations must validate organization scope.
- Sensitive assets should use signed URL flow.
- Public URLs are allowed only for explicitly public assets.

## Next implementation tasks

- Add storage provider interface in server services.
- Implement S3-compatible adapter (AWS S3 / MinIO).
- Add signed upload and signed download endpoint flow.
