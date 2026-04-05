import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/request_scope.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/classroom_service.dart';

class ClassroomEndpoint extends Endpoint {
  ClassroomEndpoint();

  final _accessControl = const AccessControlService();
  final _classroomService = const ClassroomService();
  final _activityLogService = const ActivityLogService();

  Future<List<Classroom>> listClassrooms(
    Session session, {
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 20,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _classroomService.listByOrganization(
      session,
      organizationId: orgId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<Classroom> createClassroom(
    Session session, {
    required String organizationId,
    required String actorId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final classroom = await _classroomService.create(
      session,
      organizationId: orgId,
      name: name,
      description: description,
      ageGroupMin: ageGroupMin,
      ageGroupMax: ageGroupMax,
      capacity: capacity,
      color: color,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'classroom.create',
      entityType: 'classroom',
      entityId: classroom.id,
      metadata: 'name=$name',
    );

    return classroom;
  }

  Future<Classroom> updateClassroom(
    Session session, {
    required String organizationId,
    required String actorId,
    required int classroomId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final classroom = await _classroomService.getById(
      session,
      organizationId: orgId,
      classroomId: classroomId,
    );
    if (classroom == null) {
      throw Exception('Classroom not found.');
    }

    final updated = await _classroomService.update(
      session,
      classroom: classroom,
      name: name,
      description: description,
      ageGroupMin: ageGroupMin,
      ageGroupMax: ageGroupMax,
      capacity: capacity,
      color: color,
      status: status,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'classroom.update',
      entityType: 'classroom',
      entityId: updated.id,
      metadata: 'classroomId=$classroomId',
    );

    return updated;
  }

  Future<ClassroomAssignment> assignChildToClassroom(
    Session session, {
    required String organizationId,
    required String actorId,
    required int classroomId,
    required int childId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final classroom = await _classroomService.getById(
      session,
      organizationId: orgId,
      classroomId: classroomId,
    );
    if (classroom == null) {
      throw Exception('Classroom not found.');
    }

    final child = await Child.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(childId) &
          t.organizationId.equals(orgId) &
          t.deletedAt.equals(null),
    );
    if (child == null) {
      throw Exception('Child not found.');
    }

    final assignment = await _classroomService.assignChild(
      session,
      organizationId: orgId,
      classroomId: classroomId,
      childId: childId,
      assignedByUserId: actor.id!,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'classroom.assign_child',
      entityType: 'classroom_assignment',
      entityId: assignment.id,
      metadata: 'classroomId=$classroomId;childId=$childId',
    );

    return assignment;
  }

  Future<List<ClassroomAssignment>> listAssignments(
    Session session, {
    required String organizationId,
    required String actorId,
    int? classroomId,
    int? childId,
    bool onlyActive = true,
    int page = 0,
    int pageSize = 50,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 200);

    return _classroomService.listAssignments(
      session,
      organizationId: orgId,
      classroomId: classroomId,
      childId: childId,
      onlyActive: onlyActive,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }
}
