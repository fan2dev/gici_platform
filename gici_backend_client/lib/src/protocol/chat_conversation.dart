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

abstract class ChatConversation implements _i1.SerializableModel {
  ChatConversation._({
    this.id,
    required this.organizationId,
    this.title,
    required this.conversationType,
    this.relatedChildId,
    this.relatedClassroomId,
    required this.createdByUserId,
    required this.isArchived,
    this.lastMessageAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatConversation({
    int? id,
    required int organizationId,
    String? title,
    required String conversationType,
    int? relatedChildId,
    int? relatedClassroomId,
    required int createdByUserId,
    required bool isArchived,
    DateTime? lastMessageAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatConversationImpl;

  factory ChatConversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatConversation(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      title: jsonSerialization['title'] as String?,
      conversationType: jsonSerialization['conversationType'] as String,
      relatedChildId: jsonSerialization['relatedChildId'] as int?,
      relatedClassroomId: jsonSerialization['relatedClassroomId'] as int?,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      isArchived: jsonSerialization['isArchived'] as bool,
      lastMessageAt: jsonSerialization['lastMessageAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMessageAt']),
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

  String? title;

  String conversationType;

  int? relatedChildId;

  int? relatedClassroomId;

  int createdByUserId;

  bool isArchived;

  DateTime? lastMessageAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ChatConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatConversation copyWith({
    int? id,
    int? organizationId,
    String? title,
    String? conversationType,
    int? relatedChildId,
    int? relatedClassroomId,
    int? createdByUserId,
    bool? isArchived,
    DateTime? lastMessageAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (title != null) 'title': title,
      'conversationType': conversationType,
      if (relatedChildId != null) 'relatedChildId': relatedChildId,
      if (relatedClassroomId != null) 'relatedClassroomId': relatedClassroomId,
      'createdByUserId': createdByUserId,
      'isArchived': isArchived,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
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

class _ChatConversationImpl extends ChatConversation {
  _ChatConversationImpl({
    int? id,
    required int organizationId,
    String? title,
    required String conversationType,
    int? relatedChildId,
    int? relatedClassroomId,
    required int createdByUserId,
    required bool isArchived,
    DateTime? lastMessageAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          title: title,
          conversationType: conversationType,
          relatedChildId: relatedChildId,
          relatedClassroomId: relatedClassroomId,
          createdByUserId: createdByUserId,
          isArchived: isArchived,
          lastMessageAt: lastMessageAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ChatConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatConversation copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? title = _Undefined,
    String? conversationType,
    Object? relatedChildId = _Undefined,
    Object? relatedClassroomId = _Undefined,
    int? createdByUserId,
    bool? isArchived,
    Object? lastMessageAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatConversation(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      title: title is String? ? title : this.title,
      conversationType: conversationType ?? this.conversationType,
      relatedChildId:
          relatedChildId is int? ? relatedChildId : this.relatedChildId,
      relatedClassroomId: relatedClassroomId is int?
          ? relatedClassroomId
          : this.relatedClassroomId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      isArchived: isArchived ?? this.isArchived,
      lastMessageAt:
          lastMessageAt is DateTime? ? lastMessageAt : this.lastMessageAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
