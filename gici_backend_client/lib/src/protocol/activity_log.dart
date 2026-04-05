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

abstract class ActivityLog implements _i1.SerializableModel {
  ActivityLog._({
    this.id,
    required this.organizationId,
    this.userId,
    required this.action,
    this.entityType,
    this.entityId,
    this.oldValues,
    this.newValues,
    this.ipAddress,
    this.userAgent,
    this.metadata,
    required this.createdAt,
  });

  factory ActivityLog({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i1.UuidValue? userId,
    required String action,
    String? entityType,
    String? entityId,
    String? oldValues,
    String? newValues,
    String? ipAddress,
    String? userAgent,
    String? metadata,
    required DateTime createdAt,
  }) = _ActivityLogImpl;

  factory ActivityLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityLog(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: jsonSerialization['userId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      action: jsonSerialization['action'] as String,
      entityType: jsonSerialization['entityType'] as String?,
      entityId: jsonSerialization['entityId'] as String?,
      oldValues: jsonSerialization['oldValues'] as String?,
      newValues: jsonSerialization['newValues'] as String?,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      metadata: jsonSerialization['metadata'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue? userId;

  String action;

  String? entityType;

  String? entityId;

  String? oldValues;

  String? newValues;

  String? ipAddress;

  String? userAgent;

  String? metadata;

  DateTime createdAt;

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ActivityLog copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    String? action,
    String? entityType,
    String? entityId,
    String? oldValues,
    String? newValues,
    String? ipAddress,
    String? userAgent,
    String? metadata,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (userId != null) 'userId': userId?.toJson(),
      'action': action,
      if (entityType != null) 'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (oldValues != null) 'oldValues': oldValues,
      if (newValues != null) 'newValues': newValues,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      if (metadata != null) 'metadata': metadata,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityLogImpl extends ActivityLog {
  _ActivityLogImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i1.UuidValue? userId,
    required String action,
    String? entityType,
    String? entityId,
    String? oldValues,
    String? newValues,
    String? ipAddress,
    String? userAgent,
    String? metadata,
    required DateTime createdAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          action: action,
          entityType: entityType,
          entityId: entityId,
          oldValues: oldValues,
          newValues: newValues,
          ipAddress: ipAddress,
          userAgent: userAgent,
          metadata: metadata,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ActivityLog copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    Object? userId = _Undefined,
    String? action,
    Object? entityType = _Undefined,
    Object? entityId = _Undefined,
    Object? oldValues = _Undefined,
    Object? newValues = _Undefined,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    Object? metadata = _Undefined,
    DateTime? createdAt,
  }) {
    return ActivityLog(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId is _i1.UuidValue? ? userId : this.userId,
      action: action ?? this.action,
      entityType: entityType is String? ? entityType : this.entityType,
      entityId: entityId is String? ? entityId : this.entityId,
      oldValues: oldValues is String? ? oldValues : this.oldValues,
      newValues: newValues is String? ? newValues : this.newValues,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      metadata: metadata is String? ? metadata : this.metadata,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
