import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ActivityLogService {
  const ActivityLogService();

  Future<void> log(
    Session session, {
    required UuidValue organizationId,
    required String action,
    String? entityType,
    String? entityId,
    UuidValue? userId,
    String? oldValues,
    String? newValues,
    String? metadata,
  }) async {
    final log = ActivityLog(
      organizationId: organizationId,
      userId: userId,
      action: action,
      entityType: entityType,
      entityId: entityId,
      oldValues: oldValues,
      newValues: newValues,
      ipAddress: null,
      userAgent: null,
      metadata: metadata,
      createdAt: DateTime.now().toUtc(),
    );

    await ActivityLog.db.insertRow(session, log);
  }
}
