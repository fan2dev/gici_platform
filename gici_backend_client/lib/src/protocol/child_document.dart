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

abstract class ChildDocument implements _i1.SerializableModel {
  ChildDocument._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.fileAssetId,
    required this.title,
    this.description,
    required this.visibleToGuardians,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ChildDocument({
    int? id,
    required int organizationId,
    required int childId,
    required int fileAssetId,
    required String title,
    String? description,
    required bool visibleToGuardians,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _ChildDocumentImpl;

  factory ChildDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChildDocument(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      fileAssetId: jsonSerialization['fileAssetId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      visibleToGuardians: jsonSerialization['visibleToGuardians'] as bool,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
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

  int childId;

  int fileAssetId;

  String title;

  String? description;

  bool visibleToGuardians;

  int createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [ChildDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChildDocument copyWith({
    int? id,
    int? organizationId,
    int? childId,
    int? fileAssetId,
    String? title,
    String? description,
    bool? visibleToGuardians,
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'fileAssetId': fileAssetId,
      'title': title,
      if (description != null) 'description': description,
      'visibleToGuardians': visibleToGuardians,
      'createdByUserId': createdByUserId,
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

class _ChildDocumentImpl extends ChildDocument {
  _ChildDocumentImpl({
    int? id,
    required int organizationId,
    required int childId,
    required int fileAssetId,
    required String title,
    String? description,
    required bool visibleToGuardians,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          fileAssetId: fileAssetId,
          title: title,
          description: description,
          visibleToGuardians: visibleToGuardians,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [ChildDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChildDocument copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    int? fileAssetId,
    String? title,
    Object? description = _Undefined,
    bool? visibleToGuardians,
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return ChildDocument(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      fileAssetId: fileAssetId ?? this.fileAssetId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      visibleToGuardians: visibleToGuardians ?? this.visibleToGuardians,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
