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

abstract class OrganizationDocument
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  OrganizationDocument._({
    this.id,
    required this.organizationId,
    required this.fileAssetId,
    required this.title,
    this.description,
    required this.visibility,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory OrganizationDocument({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue fileAssetId,
    required String title,
    String? description,
    required String visibility,
    required _i1.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _OrganizationDocumentImpl;

  factory OrganizationDocument.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return OrganizationDocument(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      fileAssetId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['fileAssetId']),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      visibility: jsonSerialization['visibility'] as String,
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

  static final t = OrganizationDocumentTable();

  static const db = OrganizationDocumentRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue fileAssetId;

  String title;

  String? description;

  String visibility;

  _i1.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [OrganizationDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationDocument copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? fileAssetId,
    String? title,
    String? description,
    String? visibility,
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
      'fileAssetId': fileAssetId.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'visibility': visibility,
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
      'fileAssetId': fileAssetId.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'visibility': visibility,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static OrganizationDocumentInclude include() {
    return OrganizationDocumentInclude._();
  }

  static OrganizationDocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<OrganizationDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationDocumentTable>? orderByList,
    OrganizationDocumentInclude? include,
  }) {
    return OrganizationDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrganizationDocument.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrganizationDocument.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationDocumentImpl extends OrganizationDocument {
  _OrganizationDocumentImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue fileAssetId,
    required String title,
    String? description,
    required String visibility,
    required _i1.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          fileAssetId: fileAssetId,
          title: title,
          description: description,
          visibility: visibility,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [OrganizationDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationDocument copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? fileAssetId,
    String? title,
    Object? description = _Undefined,
    String? visibility,
    _i1.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return OrganizationDocument(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      fileAssetId: fileAssetId ?? this.fileAssetId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      visibility: visibility ?? this.visibility,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class OrganizationDocumentTable extends _i1.Table<_i1.UuidValue?> {
  OrganizationDocumentTable({super.tableRelation})
      : super(tableName: 'organization_document') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    fileAssetId = _i1.ColumnUuid(
      'fileAssetId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    visibility = _i1.ColumnString(
      'visibility',
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

  late final _i1.ColumnUuid fileAssetId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString visibility;

  late final _i1.ColumnUuid createdByUserId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        fileAssetId,
        title,
        description,
        visibility,
        createdByUserId,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class OrganizationDocumentInclude extends _i1.IncludeObject {
  OrganizationDocumentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => OrganizationDocument.t;
}

class OrganizationDocumentIncludeList extends _i1.IncludeList {
  OrganizationDocumentIncludeList._({
    _i1.WhereExpressionBuilder<OrganizationDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrganizationDocument.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => OrganizationDocument.t;
}

class OrganizationDocumentRepository {
  const OrganizationDocumentRepository._();

  /// Returns a list of [OrganizationDocument]s matching the given query parameters.
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
  Future<List<OrganizationDocument>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationDocumentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<OrganizationDocument>(
      where: where?.call(OrganizationDocument.t),
      orderBy: orderBy?.call(OrganizationDocument.t),
      orderByList: orderByList?.call(OrganizationDocument.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [OrganizationDocument] matching the given query parameters.
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
  Future<OrganizationDocument?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationDocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrganizationDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationDocumentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<OrganizationDocument>(
      where: where?.call(OrganizationDocument.t),
      orderBy: orderBy?.call(OrganizationDocument.t),
      orderByList: orderByList?.call(OrganizationDocument.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [OrganizationDocument] by its [id] or null if no such row exists.
  Future<OrganizationDocument?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<OrganizationDocument>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [OrganizationDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [OrganizationDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<OrganizationDocument>> insert(
    _i1.Session session,
    List<OrganizationDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<OrganizationDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [OrganizationDocument] and returns the inserted row.
  ///
  /// The returned [OrganizationDocument] will have its `id` field set.
  Future<OrganizationDocument> insertRow(
    _i1.Session session,
    OrganizationDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrganizationDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrganizationDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrganizationDocument>> update(
    _i1.Session session,
    List<OrganizationDocument> rows, {
    _i1.ColumnSelections<OrganizationDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrganizationDocument>(
      rows,
      columns: columns?.call(OrganizationDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrganizationDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrganizationDocument> updateRow(
    _i1.Session session,
    OrganizationDocument row, {
    _i1.ColumnSelections<OrganizationDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrganizationDocument>(
      row,
      columns: columns?.call(OrganizationDocument.t),
      transaction: transaction,
    );
  }

  /// Deletes all [OrganizationDocument]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrganizationDocument>> delete(
    _i1.Session session,
    List<OrganizationDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrganizationDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrganizationDocument].
  Future<OrganizationDocument> deleteRow(
    _i1.Session session,
    OrganizationDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrganizationDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrganizationDocument>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrganizationDocumentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrganizationDocument>(
      where: where(OrganizationDocument.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationDocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrganizationDocument>(
      where: where?.call(OrganizationDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
