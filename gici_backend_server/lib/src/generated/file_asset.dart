/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class FileAsset
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = FileAssetTable();

  static const db = FileAssetRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static FileAssetInclude include() {
    return FileAssetInclude._();
  }

  static FileAssetIncludeList includeList({
    _i1.WhereExpressionBuilder<FileAssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FileAssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FileAssetTable>? orderByList,
    FileAssetInclude? include,
  }) {
    return FileAssetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FileAsset.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FileAsset.t),
      include: include,
    );
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

class FileAssetTable extends _i1.Table<int?> {
  FileAssetTable({super.tableRelation}) : super(tableName: 'file_asset') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    uploadedByUserId = _i1.ColumnInt(
      'uploadedByUserId',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    originalName = _i1.ColumnString(
      'originalName',
      this,
    );
    mimeType = _i1.ColumnString(
      'mimeType',
      this,
    );
    sizeBytes = _i1.ColumnInt(
      'sizeBytes',
      this,
    );
    storageProvider = _i1.ColumnString(
      'storageProvider',
      this,
    );
    storageBucket = _i1.ColumnString(
      'storageBucket',
      this,
    );
    storagePath = _i1.ColumnString(
      'storagePath',
      this,
    );
    publicUrl = _i1.ColumnString(
      'publicUrl',
      this,
    );
    thumbnailUrl = _i1.ColumnString(
      'thumbnailUrl',
      this,
    );
    fileType = _i1.ColumnString(
      'fileType',
      this,
    );
    isPublic = _i1.ColumnBool(
      'isPublic',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnInt uploadedByUserId;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString originalName;

  late final _i1.ColumnString mimeType;

  late final _i1.ColumnInt sizeBytes;

  late final _i1.ColumnString storageProvider;

  late final _i1.ColumnString storageBucket;

  late final _i1.ColumnString storagePath;

  late final _i1.ColumnString publicUrl;

  late final _i1.ColumnString thumbnailUrl;

  late final _i1.ColumnString fileType;

  late final _i1.ColumnBool isPublic;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        uploadedByUserId,
        fileName,
        originalName,
        mimeType,
        sizeBytes,
        storageProvider,
        storageBucket,
        storagePath,
        publicUrl,
        thumbnailUrl,
        fileType,
        isPublic,
        expiresAt,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class FileAssetInclude extends _i1.IncludeObject {
  FileAssetInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FileAsset.t;
}

class FileAssetIncludeList extends _i1.IncludeList {
  FileAssetIncludeList._({
    _i1.WhereExpressionBuilder<FileAssetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FileAsset.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FileAsset.t;
}

class FileAssetRepository {
  const FileAssetRepository._();

  /// Returns a list of [FileAsset]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<FileAsset>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FileAssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FileAssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FileAssetTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FileAsset>(
      where: where?.call(FileAsset.t),
      orderBy: orderBy?.call(FileAsset.t),
      orderByList: orderByList?.call(FileAsset.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FileAsset] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<FileAsset?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FileAssetTable>? where,
    int? offset,
    _i1.OrderByBuilder<FileAssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FileAssetTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FileAsset>(
      where: where?.call(FileAsset.t),
      orderBy: orderBy?.call(FileAsset.t),
      orderByList: orderByList?.call(FileAsset.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FileAsset] by its [id] or null if no such row exists.
  Future<FileAsset?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FileAsset>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FileAsset]s in the list and returns the inserted rows.
  ///
  /// The returned [FileAsset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FileAsset>> insert(
    _i1.Session session,
    List<FileAsset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FileAsset>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FileAsset] and returns the inserted row.
  ///
  /// The returned [FileAsset] will have its `id` field set.
  Future<FileAsset> insertRow(
    _i1.Session session,
    FileAsset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FileAsset>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FileAsset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FileAsset>> update(
    _i1.Session session,
    List<FileAsset> rows, {
    _i1.ColumnSelections<FileAssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FileAsset>(
      rows,
      columns: columns?.call(FileAsset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FileAsset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FileAsset> updateRow(
    _i1.Session session,
    FileAsset row, {
    _i1.ColumnSelections<FileAssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FileAsset>(
      row,
      columns: columns?.call(FileAsset.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FileAsset]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FileAsset>> delete(
    _i1.Session session,
    List<FileAsset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FileAsset>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FileAsset].
  Future<FileAsset> deleteRow(
    _i1.Session session,
    FileAsset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FileAsset>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FileAsset>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FileAssetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FileAsset>(
      where: where(FileAsset.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FileAssetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FileAsset>(
      where: where?.call(FileAsset.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
