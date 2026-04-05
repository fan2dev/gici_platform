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

abstract class GalleryItem
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue galleryId,
    required _i1.UuidValue fileAssetId,
    String? caption,
    required int sortOrder,
    required _i1.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _GalleryItemImpl;

  factory GalleryItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return GalleryItem(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      galleryId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['galleryId']),
      fileAssetId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['fileAssetId']),
      caption: jsonSerialization['caption'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int,
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['createdByUserId']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = GalleryItemTable();

  static const db = GalleryItemRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue galleryId;

  _i1.UuidValue fileAssetId;

  String? caption;

  int sortOrder;

  _i1.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [GalleryItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GalleryItem copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? galleryId,
    _i1.UuidValue? fileAssetId,
    String? caption,
    int? sortOrder,
    _i1.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'galleryId': galleryId.toJson(),
      'fileAssetId': fileAssetId.toJson(),
      if (caption != null) 'caption': caption,
      'sortOrder': sortOrder,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'galleryId': galleryId.toJson(),
      'fileAssetId': fileAssetId.toJson(),
      if (caption != null) 'caption': caption,
      'sortOrder': sortOrder,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static GalleryItemInclude include() {
    return GalleryItemInclude._();
  }

  static GalleryItemIncludeList includeList({
    _i1.WhereExpressionBuilder<GalleryItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GalleryItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GalleryItemTable>? orderByList,
    GalleryItemInclude? include,
  }) {
    return GalleryItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GalleryItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GalleryItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GalleryItemImpl extends GalleryItem {
  _GalleryItemImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue galleryId,
    required _i1.UuidValue fileAssetId,
    String? caption,
    required int sortOrder,
    required _i1.UuidValue createdByUserId,
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
    _i1.UuidValue? organizationId,
    _i1.UuidValue? galleryId,
    _i1.UuidValue? fileAssetId,
    Object? caption = _Undefined,
    int? sortOrder,
    _i1.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return GalleryItem(
      id: id is _i1.UuidValue? ? id : this.id,
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

class GalleryItemTable extends _i1.Table<_i1.UuidValue?> {
  GalleryItemTable({super.tableRelation}) : super(tableName: 'gallery_item') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    galleryId = _i1.ColumnUuid(
      'galleryId',
      this,
    );
    fileAssetId = _i1.ColumnUuid(
      'fileAssetId',
      this,
    );
    caption = _i1.ColumnString(
      'caption',
      this,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
    );
    createdByUserId = _i1.ColumnUuid(
      'createdByUserId',
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

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnUuid galleryId;

  late final _i1.ColumnUuid fileAssetId;

  late final _i1.ColumnString caption;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnUuid createdByUserId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        galleryId,
        fileAssetId,
        caption,
        sortOrder,
        createdByUserId,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class GalleryItemInclude extends _i1.IncludeObject {
  GalleryItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => GalleryItem.t;
}

class GalleryItemIncludeList extends _i1.IncludeList {
  GalleryItemIncludeList._({
    _i1.WhereExpressionBuilder<GalleryItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GalleryItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => GalleryItem.t;
}

class GalleryItemRepository {
  const GalleryItemRepository._();

  /// Returns a list of [GalleryItem]s matching the given query parameters.
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
  Future<List<GalleryItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GalleryItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GalleryItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GalleryItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<GalleryItem>(
      where: where?.call(GalleryItem.t),
      orderBy: orderBy?.call(GalleryItem.t),
      orderByList: orderByList?.call(GalleryItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [GalleryItem] matching the given query parameters.
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
  Future<GalleryItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GalleryItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<GalleryItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GalleryItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<GalleryItem>(
      where: where?.call(GalleryItem.t),
      orderBy: orderBy?.call(GalleryItem.t),
      orderByList: orderByList?.call(GalleryItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [GalleryItem] by its [id] or null if no such row exists.
  Future<GalleryItem?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<GalleryItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [GalleryItem]s in the list and returns the inserted rows.
  ///
  /// The returned [GalleryItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<GalleryItem>> insert(
    _i1.Session session,
    List<GalleryItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<GalleryItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [GalleryItem] and returns the inserted row.
  ///
  /// The returned [GalleryItem] will have its `id` field set.
  Future<GalleryItem> insertRow(
    _i1.Session session,
    GalleryItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GalleryItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GalleryItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GalleryItem>> update(
    _i1.Session session,
    List<GalleryItem> rows, {
    _i1.ColumnSelections<GalleryItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GalleryItem>(
      rows,
      columns: columns?.call(GalleryItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GalleryItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GalleryItem> updateRow(
    _i1.Session session,
    GalleryItem row, {
    _i1.ColumnSelections<GalleryItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GalleryItem>(
      row,
      columns: columns?.call(GalleryItem.t),
      transaction: transaction,
    );
  }

  /// Deletes all [GalleryItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GalleryItem>> delete(
    _i1.Session session,
    List<GalleryItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GalleryItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GalleryItem].
  Future<GalleryItem> deleteRow(
    _i1.Session session,
    GalleryItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GalleryItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GalleryItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GalleryItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GalleryItem>(
      where: where(GalleryItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GalleryItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GalleryItem>(
      where: where?.call(GalleryItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
