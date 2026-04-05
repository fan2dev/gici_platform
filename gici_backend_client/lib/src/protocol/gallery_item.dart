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

abstract class GalleryItem implements _i1.SerializableModel {
  GalleryItem._({
    this.id,
    required this.organizationId,
    required this.galleryId,
    required this.fileAssetId,
    this.caption,
    required this.sortOrder,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory GalleryItem({
    int? id,
    required int organizationId,
    required int galleryId,
    required int fileAssetId,
    String? caption,
    required int sortOrder,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _GalleryItemImpl;

  factory GalleryItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return GalleryItem(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      galleryId: jsonSerialization['galleryId'] as int,
      fileAssetId: jsonSerialization['fileAssetId'] as int,
      caption: jsonSerialization['caption'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int,
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

  int galleryId;

  int fileAssetId;

  String? caption;

  int sortOrder;

  int createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [GalleryItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GalleryItem copyWith({
    int? id,
    int? organizationId,
    int? galleryId,
    int? fileAssetId,
    String? caption,
    int? sortOrder,
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
      'galleryId': galleryId,
      'fileAssetId': fileAssetId,
      if (caption != null) 'caption': caption,
      'sortOrder': sortOrder,
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

class _GalleryItemImpl extends GalleryItem {
  _GalleryItemImpl({
    int? id,
    required int organizationId,
    required int galleryId,
    required int fileAssetId,
    String? caption,
    required int sortOrder,
    required int createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          galleryId: galleryId,
          fileAssetId: fileAssetId,
          caption: caption,
          sortOrder: sortOrder,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [GalleryItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GalleryItem copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? galleryId,
    int? fileAssetId,
    Object? caption = _Undefined,
    int? sortOrder,
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return GalleryItem(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      galleryId: galleryId ?? this.galleryId,
      fileAssetId: fileAssetId ?? this.fileAssetId,
      caption: caption is String? ? caption : this.caption,
      sortOrder: sortOrder ?? this.sortOrder,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
