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

abstract class PedagogicalReport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PedagogicalReport._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.reportDate,
    required this.title,
    required this.summary,
    required this.body,
    required this.status,
    required this.visibility,
    required this.createdByUserId,
    this.updatedByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PedagogicalReport({
    int? id,
    required int organizationId,
    required int childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    required String status,
    required String visibility,
    required int createdByUserId,
    int? updatedByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _PedagogicalReportImpl;

  factory PedagogicalReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return PedagogicalReport(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      reportDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reportDate']),
      title: jsonSerialization['title'] as String,
      summary: jsonSerialization['summary'] as String,
      body: jsonSerialization['body'] as String,
      status: jsonSerialization['status'] as String,
      visibility: jsonSerialization['visibility'] as String,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      updatedByUserId: jsonSerialization['updatedByUserId'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = PedagogicalReportTable();

  static const db = PedagogicalReportRepository._();

  @override
  int? id;

  int organizationId;

  int childId;

  DateTime reportDate;

  String title;

  String summary;

  String body;

  String status;

  String visibility;

  int createdByUserId;

  int? updatedByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PedagogicalReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PedagogicalReport copyWith({
    int? id,
    int? organizationId,
    int? childId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
    int? createdByUserId,
    int? updatedByUserId,
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
      'reportDate': reportDate.toJson(),
      'title': title,
      'summary': summary,
      'body': body,
      'status': status,
      'visibility': visibility,
      'createdByUserId': createdByUserId,
      if (updatedByUserId != null) 'updatedByUserId': updatedByUserId,
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
      'reportDate': reportDate.toJson(),
      'title': title,
      'summary': summary,
      'body': body,
      'status': status,
      'visibility': visibility,
      'createdByUserId': createdByUserId,
      if (updatedByUserId != null) 'updatedByUserId': updatedByUserId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static PedagogicalReportInclude include() {
    return PedagogicalReportInclude._();
  }

  static PedagogicalReportIncludeList includeList({
    _i1.WhereExpressionBuilder<PedagogicalReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PedagogicalReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PedagogicalReportTable>? orderByList,
    PedagogicalReportInclude? include,
  }) {
    return PedagogicalReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PedagogicalReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PedagogicalReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PedagogicalReportImpl extends PedagogicalReport {
  _PedagogicalReportImpl({
    int? id,
    required int organizationId,
    required int childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    required String status,
    required String visibility,
    required int createdByUserId,
    int? updatedByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          reportDate: reportDate,
          title: title,
          summary: summary,
          body: body,
          status: status,
          visibility: visibility,
          createdByUserId: createdByUserId,
          updatedByUserId: updatedByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [PedagogicalReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PedagogicalReport copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
    int? createdByUserId,
    Object? updatedByUserId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return PedagogicalReport(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      reportDate: reportDate ?? this.reportDate,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      body: body ?? this.body,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      updatedByUserId:
          updatedByUserId is int? ? updatedByUserId : this.updatedByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class PedagogicalReportTable extends _i1.Table<int?> {
  PedagogicalReportTable({super.tableRelation})
      : super(tableName: 'pedagogical_report') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    childId = _i1.ColumnInt(
      'childId',
      this,
    );
    reportDate = _i1.ColumnDateTime(
      'reportDate',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    summary = _i1.ColumnString(
      'summary',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    visibility = _i1.ColumnString(
      'visibility',
      this,
    );
    createdByUserId = _i1.ColumnInt(
      'createdByUserId',
      this,
    );
    updatedByUserId = _i1.ColumnInt(
      'updatedByUserId',
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

  late final _i1.ColumnDateTime reportDate;

  late final _i1.ColumnString title;

  late final _i1.ColumnString summary;

  late final _i1.ColumnString body;

  late final _i1.ColumnString status;

  late final _i1.ColumnString visibility;

  late final _i1.ColumnInt createdByUserId;

  late final _i1.ColumnInt updatedByUserId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        reportDate,
        title,
        summary,
        body,
        status,
        visibility,
        createdByUserId,
        updatedByUserId,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}

class PedagogicalReportInclude extends _i1.IncludeObject {
  PedagogicalReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PedagogicalReport.t;
}

class PedagogicalReportIncludeList extends _i1.IncludeList {
  PedagogicalReportIncludeList._({
    _i1.WhereExpressionBuilder<PedagogicalReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PedagogicalReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PedagogicalReport.t;
}

class PedagogicalReportRepository {
  const PedagogicalReportRepository._();

  /// Returns a list of [PedagogicalReport]s matching the given query parameters.
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
  Future<List<PedagogicalReport>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PedagogicalReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PedagogicalReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PedagogicalReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PedagogicalReport>(
      where: where?.call(PedagogicalReport.t),
      orderBy: orderBy?.call(PedagogicalReport.t),
      orderByList: orderByList?.call(PedagogicalReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PedagogicalReport] matching the given query parameters.
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
  Future<PedagogicalReport?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PedagogicalReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<PedagogicalReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PedagogicalReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PedagogicalReport>(
      where: where?.call(PedagogicalReport.t),
      orderBy: orderBy?.call(PedagogicalReport.t),
      orderByList: orderByList?.call(PedagogicalReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PedagogicalReport] by its [id] or null if no such row exists.
  Future<PedagogicalReport?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PedagogicalReport>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PedagogicalReport]s in the list and returns the inserted rows.
  ///
  /// The returned [PedagogicalReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PedagogicalReport>> insert(
    _i1.Session session,
    List<PedagogicalReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PedagogicalReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PedagogicalReport] and returns the inserted row.
  ///
  /// The returned [PedagogicalReport] will have its `id` field set.
  Future<PedagogicalReport> insertRow(
    _i1.Session session,
    PedagogicalReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PedagogicalReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PedagogicalReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PedagogicalReport>> update(
    _i1.Session session,
    List<PedagogicalReport> rows, {
    _i1.ColumnSelections<PedagogicalReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PedagogicalReport>(
      rows,
      columns: columns?.call(PedagogicalReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PedagogicalReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PedagogicalReport> updateRow(
    _i1.Session session,
    PedagogicalReport row, {
    _i1.ColumnSelections<PedagogicalReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PedagogicalReport>(
      row,
      columns: columns?.call(PedagogicalReport.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PedagogicalReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PedagogicalReport>> delete(
    _i1.Session session,
    List<PedagogicalReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PedagogicalReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PedagogicalReport].
  Future<PedagogicalReport> deleteRow(
    _i1.Session session,
    PedagogicalReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PedagogicalReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PedagogicalReport>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PedagogicalReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PedagogicalReport>(
      where: where(PedagogicalReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PedagogicalReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PedagogicalReport>(
      where: where?.call(PedagogicalReport.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
