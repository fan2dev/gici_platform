import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ActivityLogService {
  const ActivityLogService();

  Future<void> log(
    Session session, {
    required int organizationId,
    required String action,
    String? entityType,
    int? entityId,
    int? userId,
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
