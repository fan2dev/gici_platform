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

abstract class NotificationRecord implements _i1.SerializableModel {
  NotificationRecord._({
    this.id,
    required this.organizationId,
    required this.userId,
    required this.title,
    required this.body,
    required this.category,
    required this.targetScope,
    this.targetClassroomId,
    this.targetChildId,
    this.targetUserId,
    required this.createdByUserId,
    required this.isRead,
    this.readAt,
    required this.createdAt,
  });

  factory NotificationRecord({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required String category,
    required String targetScope,
    _i1.UuidValue? targetClassroomId,
    _i1.UuidValue? targetChildId,
    _i1.UuidValue? targetUserId,
    required _i1.UuidValue createdByUserId,
    required bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _NotificationRecordImpl;

  factory NotificationRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return NotificationRecord(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      category: jsonSerialization['category'] as String,
      targetScope: jsonSerialization['targetScope'] as String,
      targetClassroomId: jsonSerialization['targetClassroomId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['targetClassroomId']),
      targetChildId: jsonSerialization['targetChildId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['targetChildId']),
      targetUserId: jsonSerialization['targetUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['targetUserId']),
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['createdByUserId']),
      isRead: jsonSerialization['isRead'] as bool,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue userId;

  String title;

  String body;

  String category;

  String targetScope;

  _i1.UuidValue? targetClassroomId;

  _i1.UuidValue? targetChildId;

  _i1.UuidValue? targetUserId;

  _i1.UuidValue createdByUserId;

  bool isRead;

  DateTime? readAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [NotificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationRecord copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    String? category,
    String? targetScope,
    _i1.UuidValue? targetClassroomId,
    _i1.UuidValue? targetChildId,
    _i1.UuidValue? targetUserId,
    _i1.UuidValue? createdByUserId,
    bool? isRead,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'userId': userId.toJson(),
      'title': title,
      'body': body,
      'category': category,
      'targetScope': targetScope,
      if (targetClassroomId != null)
        'targetClassroomId': targetClassroomId?.toJson(),
      if (targetChildId != null) 'targetChildId': targetChildId?.toJson(),
      if (targetUserId != null) 'targetUserId': targetUserId?.toJson(),
      'createdByUserId': createdByUserId.toJson(),
      'isRead': isRead,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationRecordImpl extends NotificationRecord {
  _NotificationRecordImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required String category,
    required String targetScope,
    _i1.UuidValue? targetClassroomId,
    _i1.UuidValue? targetChildId,
    _i1.UuidValue? targetUserId,
    required _i1.UuidValue createdByUserId,
    required bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          userId: userId,
          title: title,
          body: body,
          category: category,
          targetScope: targetScope,
          targetClassroomId: targetClassroomId,
          targetChildId: targetChildId,
          targetUserId: targetUserId,
          createdByUserId: createdByUserId,
          isRead: isRead,
          readAt: readAt,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [NotificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    String? category,
    String? targetScope,
    Object? targetClassroomId = _Undefined,
    Object? targetChildId = _Undefined,
    Object? targetUserId = _Undefined,
    _i1.UuidValue? createdByUserId,
    bool? isRead,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return NotificationRecord(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      targetScope: targetScope ?? this.targetScope,
      targetClassroomId: targetClassroomId is _i1.UuidValue?
          ? targetClassroomId
          : this.targetClassroomId,
      targetChildId:
          targetChildId is _i1.UuidValue? ? targetChildId : this.targetChildId,
      targetUserId:
          targetUserId is _i1.UuidValue? ? targetUserId : this.targetUserId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      isRead: isRead ?? this.isRead,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
