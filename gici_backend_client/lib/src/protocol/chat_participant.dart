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

abstract class ChatParticipant implements _i1.SerializableModel {
  ChatParticipant._({
    this.id,
    required this.organizationId,
    required this.conversationId,
    required this.userId,
    required this.joinedAt,
    this.lastReadMessageId,
    this.lastReadAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatParticipant({
    int? id,
    required int organizationId,
    required int conversationId,
    required int userId,
    required DateTime joinedAt,
    int? lastReadMessageId,
    DateTime? lastReadAt,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatParticipantImpl;

  factory ChatParticipant.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatParticipant(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      conversationId: jsonSerialization['conversationId'] as int,
      userId: jsonSerialization['userId'] as int,
      joinedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
      lastReadMessageId: jsonSerialization['lastReadMessageId'] as int?,
      lastReadAt: jsonSerialization['lastReadAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastReadAt']),
      isActive: jsonSerialization['isActive'] as bool,
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

  int conversationId;

  int userId;

  DateTime joinedAt;

  int? lastReadMessageId;

  DateTime? lastReadAt;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ChatParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatParticipant copyWith({
    int? id,
    int? organizationId,
    int? conversationId,
    int? userId,
    DateTime? joinedAt,
    int? lastReadMessageId,
    DateTime? lastReadAt,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'conversationId': conversationId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      if (lastReadMessageId != null) 'lastReadMessageId': lastReadMessageId,
      if (lastReadAt != null) 'lastReadAt': lastReadAt?.toJson(),
      'isActive': isActive,
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

class _ChatParticipantImpl extends ChatParticipant {
  _ChatParticipantImpl({
    int? id,
    required int organizationId,
    required int conversationId,
    required int userId,
    required DateTime joinedAt,
    int? lastReadMessageId,
    DateTime? lastReadAt,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          conversationId: conversationId,
          userId: userId,
          joinedAt: joinedAt,
          lastReadMessageId: lastReadMessageId,
          lastReadAt: lastReadAt,
          isActive: isActive,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ChatParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatParticipant copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? conversationId,
    int? userId,
    DateTime? joinedAt,
    Object? lastReadMessageId = _Undefined,
    Object? lastReadAt = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatParticipant(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
      lastReadMessageId: lastReadMessageId is int?
          ? lastReadMessageId
          : this.lastReadMessageId,
      lastReadAt: lastReadAt is DateTime? ? lastReadAt : this.lastReadAt,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
