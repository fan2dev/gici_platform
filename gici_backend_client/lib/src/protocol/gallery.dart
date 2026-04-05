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

abstract class Gallery implements _i1.SerializableModel {
  Gallery._({
    this.id,
    required this.organizationId,
    required this.title,
    this.description,
    required this.audienceType,
    this.audienceClassroomId,
    this.audienceChildId,
    required this.createdByUserId,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Gallery({
    int? id,
    required int organizationId,
    required String title,
    String? description,
    required String audienceType,
    int? audienceClassroomId,
    int? audienceChildId,
    required int createdByUserId,
    required bool isPublished,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _GalleryImpl;

  factory Gallery.fromJson(Map<String, dynamic> jsonSerialization) {
    return Gallery(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      audienceType: jsonSerialization['audienceType'] as String,
      audienceClassroomId: jsonSerialization['audienceClassroomId'] as int?,
      audienceChildId: jsonSerialization['audienceChildId'] as int?,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      isPublished: jsonSerialization['isPublished'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  String title;

  String? description;

  String audienceType;

  int? audienceClassroomId;

  int? audienceChildId;

  int createdByUserId;

  bool isPublished;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [Gallery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Gallery copyWith({
    int? id,
    int? organizationId,
    String? title,
    String? description,
    String? audienceType,
    int? audienceClassroomId,
    int? audienceChildId,
    int? createdByUserId,
    bool? isPublished,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'title': title,
      if (description != null) 'description': description,
      'audienceType': audienceType,
      if (audienceClassroomId != null)
        'audienceClassroomId': audienceClassroomId,
      if (audienceChildId != null) 'audienceChildId': audienceChildId,
      'createdByUserId': createdByUserId,
      'isPublished': isPublished,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GalleryImpl extends Gallery {
  _GalleryImpl({
    int? id,
    required int organizationId,
    required String title,
    String? description,
    required String audienceType,
    int? audienceClassroomId,
    int? audienceChildId,
    required int createdByUserId,
    required bool isPublished,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          title: title,
          description: description,
          audienceType: audienceType,
          audienceClassroomId: audienceClassroomId,
          audienceChildId: audienceChildId,
          createdByUserId: createdByUserId,
          isPublished: isPublished,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [Gallery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Gallery copyWith({
    Object? id = _Undefined,
    int? organizationId,
    String? title,
    Object? description = _Undefined,
    String? audienceType,
    Object? audienceClassroomId = _Undefined,
    Object? audienceChildId = _Undefined,
    int? createdByUserId,
    bool? isPublished,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return Gallery(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      audienceType: audienceType ?? this.audienceType,
      audienceClassroomId: audienceClassroomId is int?
          ? audienceClassroomId
          : this.audienceClassroomId,
      audienceChildId:
          audienceChildId is int? ? audienceChildId : this.audienceChildId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
