/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ClassroomAssignment implements _i1.SerializableModel {
  ClassroomAssignment._({
    this.id,
    required this.organizationId,
    required this.classroomId,
    required this.childId,
    required this.assignedAt,
    this.assignedByUserId,
    this.withdrawnAt,
    this.withdrawnByUserId,
    this.withdrawnReason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClassroomAssignment({
    int? id,
    required int organizationId,
    required int classroomId,
    required int childId,
    required DateTime assignedAt,
    int? assignedByUserId,
    DateTime? withdrawnAt,
    int? withdrawnByUserId,
    String? withdrawnReason,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ClassroomAssignmentImpl;

  factory ClassroomAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassroomAssignment(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      classroomId: jsonSerialization['classroomId'] as int,
      childId: jsonSerialization['childId'] as int,
      assignedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['assignedAt']),
      assignedByUserId: jsonSerialization['assignedByUserId'] as int?,
      withdrawnAt: jsonSerialization['withdrawnAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['withdrawnAt']),
      withdrawnByUserId: jsonSerialization['withdrawnByUserId'] as int?,
      withdrawnReason: jsonSerialization['withdrawnReason'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  int classroomId;

  int childId;

  DateTime assignedAt;

  int? assignedByUserId;

  DateTime? withdrawnAt;

  int? withdrawnByUserId;

  String? withdrawnReason;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ClassroomAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassroomAssignment copyWith({
    int? id,
    int? organizationId,
    int? classroomId,
    int? childId,
    DateTime? assignedAt,
    int? assignedByUserId,
    DateTime? withdrawnAt,
    int? withdrawnByUserId,
    String? withdrawnReason,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'classroomId': classroomId,
      'childId': childId,
      'assignedAt': assignedAt.toJson(),
      if (assignedByUserId != null) 'assignedByUserId': assignedByUserId,
      if (withdrawnAt != null) 'withdrawnAt': withdrawnAt?.toJson(),
      if (withdrawnByUserId != null) 'withdrawnByUserId': withdrawnByUserId,
      if (withdrawnReason != null) 'withdrawnReason': withdrawnReason,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassroomAssignmentImpl extends ClassroomAssignment {
  _ClassroomAssignmentImpl({
    int? id,
    required int organizationId,
    required int classroomId,
    required int childId,
    required DateTime assignedAt,
    int? assignedByUserId,
    DateTime? withdrawnAt,
    int? withdrawnByUserId,
    String? withdrawnReason,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          classroomId: classroomId,
          childId: childId,
          assignedAt: assignedAt,
          assignedByUserId: assignedByUserId,
          withdrawnAt: withdrawnAt,
          withdrawnByUserId: withdrawnByUserId,
          withdrawnReason: withdrawnReason,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassroomAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassroomAssignment copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? classroomId,
    int? childId,
    DateTime? assignedAt,
    Object? assignedByUserId = _Undefined,
    Object? withdrawnAt = _Undefined,
    Object? withdrawnByUserId = _Undefined,
    Object? withdrawnReason = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassroomAssignment(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      classroomId: classroomId ?? this.classroomId,
      childId: childId ?? this.childId,
      assignedAt: assignedAt ?? this.assignedAt,
      assignedByUserId:
          assignedByUserId is int? ? assignedByUserId : this.assignedByUserId,
      withdrawnAt: withdrawnAt is DateTime? ? withdrawnAt : this.withdrawnAt,
      withdrawnByUserId: withdrawnByUserId is int?
          ? withdrawnByUserId
          : this.withdrawnByUserId,
      withdrawnReason:
          withdrawnReason is String? ? withdrawnReason : this.withdrawnReason,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
