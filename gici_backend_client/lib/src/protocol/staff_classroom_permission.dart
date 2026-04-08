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

abstract class StaffClassroomPermission implements _i1.SerializableModel {
  StaffClassroomPermission._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.classroomId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StaffClassroomPermission({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required _i1.UuidValue classroomId,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StaffClassroomPermissionImpl;

  factory StaffClassroomPermission.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StaffClassroomPermission(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      classroomId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['classroomId']),
      role: jsonSerialization['role'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue userId;

  _i1.UuidValue classroomId;

  String role;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StaffClassroomPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StaffClassroomPermission copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    _i1.UuidValue? classroomId,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      'classroomId': classroomId.toJson(),
      'role': role,
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

class _StaffClassroomPermissionImpl extends StaffClassroomPermission {
  _StaffClassroomPermissionImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required _i1.UuidValue classroomId,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          classroomId: classroomId,
          role: role,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StaffClassroomPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StaffClassroomPermission copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    _i1.UuidValue? classroomId,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StaffClassroomPermission(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      classroomId: classroomId ?? this.classroomId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
