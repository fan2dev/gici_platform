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

abstract class ChatMessage implements _i1.SerializableModel {
  ChatMessage._({
    this.id,
    required this.organizationId,
    required this.conversationId,
    required this.senderUserId,
    required this.body,
    required this.messageType,
    this.metadataJson,
    this.deletedAt,
    required this.sentAt,
    required this.createdAt,
  });

  factory ChatMessage({
    int? id,
    required int organizationId,
    required int conversationId,
    required int senderUserId,
    required String body,
    required String messageType,
    String? metadataJson,
    DateTime? deletedAt,
    required DateTime sentAt,
    required DateTime createdAt,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMessage(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      conversationId: jsonSerialization['conversationId'] as int,
      senderUserId: jsonSerialization['senderUserId'] as int,
      body: jsonSerialization['body'] as String,
      messageType: jsonSerialization['messageType'] as String,
      metadataJson: jsonSerialization['metadataJson'] as String?,
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      sentAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  int conversationId;

  int senderUserId;

  String body;

  String messageType;

  String? metadataJson;

  DateTime? deletedAt;

  DateTime sentAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatMessage copyWith({
    int? id,
    int? organizationId,
    int? conversationId,
    int? senderUserId,
    String? body,
    String? messageType,
    String? metadataJson,
    DateTime? deletedAt,
    DateTime? sentAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'conversationId': conversationId,
      'senderUserId': senderUserId,
      'body': body,
      'messageType': messageType,
      if (metadataJson != null) 'metadataJson': metadataJson,
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      'sentAt': sentAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required int organizationId,
    required int conversationId,
    required int senderUserId,
    required String body,
    required String messageType,
    String? metadataJson,
    DateTime? deletedAt,
    required DateTime sentAt,
    required DateTime createdAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          conversationId: conversationId,
          senderUserId: senderUserId,
          body: body,
          messageType: messageType,
          metadataJson: metadataJson,
          deletedAt: deletedAt,
          sentAt: sentAt,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? conversationId,
    int? senderUserId,
    String? body,
    String? messageType,
    Object? metadataJson = _Undefined,
    Object? deletedAt = _Undefined,
    DateTime? sentAt,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      conversationId: conversationId ?? this.conversationId,
      senderUserId: senderUserId ?? this.senderUserId,
      body: body ?? this.body,
      messageType: messageType ?? this.messageType,
      metadataJson: metadataJson is String? ? metadataJson : this.metadataJson,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      sentAt: sentAt ?? this.sentAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
