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

abstract class ChildDocument
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ChildDocumentTable();

  static const db = ChildDocumentRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static ChildDocumentInclude include() {
    return ChildDocumentInclude._();
  }

  static ChildDocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<ChildDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildDocumentTable>? orderByList,
    ChildDocumentInclude? include,
  }) {
    return ChildDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChildDocument.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChildDocument.t),
      include: include,
    );
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

class ChildDocumentTable extends _i1.Table<int?> {
  ChildDocumentTable({super.tableRelation})
      : super(tableName: 'child_document') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    childId = _i1.ColumnInt(
      'childId',
      this,
    );
    fileAssetId = _i1.ColumnInt(
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
    visibleToGuardians = _i1.ColumnBool(
      'visibleToGuardians',
      this,
    );
    createdByUserId = _i1.ColumnInt(
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

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnInt childId;

  late final _i1.ColumnInt fileAssetId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnBool visibleToGuardians;

  late final _i1.ColumnInt createdByUserId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        fileAssetId,
        title,
        description,
        visibleToGuardians,
        createdByUserId,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class ChildDocumentInclude extends _i1.IncludeObject {
  ChildDocumentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChildDocument.t;
}

class ChildDocumentIncludeList extends _i1.IncludeList {
  ChildDocumentIncludeList._({
    _i1.WhereExpressionBuilder<ChildDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChildDocument.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChildDocument.t;
}

class ChildDocumentRepository {
  const ChildDocumentRepository._();

  /// Returns a list of [ChildDocument]s matching the given query parameters.
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
  Future<List<ChildDocument>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildDocumentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ChildDocument>(
      where: where?.call(ChildDocument.t),
      orderBy: orderBy?.call(ChildDocument.t),
      orderByList: orderByList?.call(ChildDocument.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ChildDocument] matching the given query parameters.
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
  Future<ChildDocument?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildDocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChildDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildDocumentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ChildDocument>(
      where: where?.call(ChildDocument.t),
      orderBy: orderBy?.call(ChildDocument.t),
      orderByList: orderByList?.call(ChildDocument.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ChildDocument] by its [id] or null if no such row exists.
  Future<ChildDocument?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ChildDocument>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ChildDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [ChildDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChildDocument>> insert(
    _i1.Session session,
    List<ChildDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChildDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChildDocument] and returns the inserted row.
  ///
  /// The returned [ChildDocument] will have its `id` field set.
  Future<ChildDocument> insertRow(
    _i1.Session session,
    ChildDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChildDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChildDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChildDocument>> update(
    _i1.Session session,
    List<ChildDocument> rows, {
    _i1.ColumnSelections<ChildDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChildDocument>(
      rows,
      columns: columns?.call(ChildDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChildDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChildDocument> updateRow(
    _i1.Session session,
    ChildDocument row, {
    _i1.ColumnSelections<ChildDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChildDocument>(
      row,
      columns: columns?.call(ChildDocument.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ChildDocument]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChildDocument>> delete(
    _i1.Session session,
    List<ChildDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChildDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChildDocument].
  Future<ChildDocument> deleteRow(
    _i1.Session session,
    ChildDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChildDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChildDocument>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChildDocumentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChildDocument>(
      where: where(ChildDocument.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildDocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChildDocument>(
      where: where?.call(ChildDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
