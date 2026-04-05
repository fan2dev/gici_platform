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

abstract class FileAsset implements _i1.SerializableModel {
  FileAsset._({
    this.id,
    required this.organizationId,
    required this.uploadedByUserId,
    required this.fileName,
    required this.originalName,
    required this.mimeType,
    required this.sizeBytes,
    required this.storageProvider,
    required this.storageBucket,
    required this.storagePath,
    this.publicUrl,
    this.thumbnailUrl,
    required this.fileType,
    required this.isPublic,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory FileAsset({
    int? id,
    required int organizationId,
    required int uploadedByUserId,
    required String fileName,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required String storageProvider,
    required String storageBucket,
    required String storagePath,
    String? publicUrl,
    String? thumbnailUrl,
    required String fileType,
    required bool isPublic,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _FileAssetImpl;

  factory FileAsset.fromJson(Map<String, dynamic> jsonSerialization) {
    return FileAsset(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      uploadedByUserId: jsonSerialization['uploadedByUserId'] as int,
      fileName: jsonSerialization['fileName'] as String,
      originalName: jsonSerialization['originalName'] as String,
      mimeType: jsonSerialization['mimeType'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      storageProvider: jsonSerialization['storageProvider'] as String,
      storageBucket: jsonSerialization['storageBucket'] as String,
      storagePath: jsonSerialization['storagePath'] as String,
      publicUrl: jsonSerialization['publicUrl'] as String?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      fileType: jsonSerialization['fileType'] as String,
      isPublic: jsonSerialization['isPublic'] as bool,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
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

  int uploadedByUserId;

  String fileName;

  String originalName;

  String mimeType;

  int sizeBytes;

  String storageProvider;

  String storageBucket;

  String storagePath;

  String? publicUrl;

  String? thumbnailUrl;

  String fileType;

  bool isPublic;

  DateTime? expiresAt;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [FileAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FileAsset copyWith({
    int? id,
    int? organizationId,
    int? uploadedByUserId,
    String? fileName,
    String? originalName,
    String? mimeType,
    int? sizeBytes,
    String? storageProvider,
    String? storageBucket,
    String? storagePath,
    String? publicUrl,
    String? thumbnailUrl,
    String? fileType,
    bool? isPublic,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'uploadedByUserId': uploadedByUserId,
      'fileName': fileName,
      'originalName': originalName,
      'mimeType': mimeType,
      'sizeBytes': sizeBytes,
      'storageProvider': storageProvider,
      'storageBucket': storageBucket,
      'storagePath': storagePath,
      if (publicUrl != null) 'publicUrl': publicUrl,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'fileType': fileType,
      'isPublic': isPublic,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
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

class _FileAssetImpl extends FileAsset {
  _FileAssetImpl({
    int? id,
    required int organizationId,
    required int uploadedByUserId,
    required String fileName,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required String storageProvider,
    required String storageBucket,
    required String storagePath,
    String? publicUrl,
    String? thumbnailUrl,
    required String fileType,
    required bool isPublic,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          uploadedByUserId: uploadedByUserId,
          fileName: fileName,
          originalName: originalName,
          mimeType: mimeType,
          sizeBytes: sizeBytes,
          storageProvider: storageProvider,
          storageBucket: storageBucket,
          storagePath: storagePath,
          publicUrl: publicUrl,
          thumbnailUrl: thumbnailUrl,
          fileType: fileType,
          isPublic: isPublic,
          expiresAt: expiresAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [FileAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FileAsset copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? uploadedByUserId,
    String? fileName,
    String? originalName,
    String? mimeType,
    int? sizeBytes,
    String? storageProvider,
    String? storageBucket,
    String? storagePath,
    Object? publicUrl = _Undefined,
    Object? thumbnailUrl = _Undefined,
    String? fileType,
    bool? isPublic,
    Object? expiresAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return FileAsset(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
      fileName: fileName ?? this.fileName,
      originalName: originalName ?? this.originalName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      storageProvider: storageProvider ?? this.storageProvider,
      storageBucket: storageBucket ?? this.storageBucket,
      storagePath: storagePath ?? this.storagePath,
      publicUrl: publicUrl is String? ? publicUrl : this.publicUrl,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      fileType: fileType ?? this.fileType,
      isPublic: isPublic ?? this.isPublic,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
