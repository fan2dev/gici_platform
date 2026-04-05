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

abstract class DataChangeRequest
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DataChangeRequest._({
    this.id,
    required this.organizationId,
    required this.requesterUserId,
    this.targetChildId,
    required this.requestType,
    required this.requestPayload,
    required this.status,
    this.resolutionNote,
    this.reviewedByUserId,
    this.reviewedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataChangeRequest({
    int? id,
    required int organizationId,
    required int requesterUserId,
    int? targetChildId,
    required String requestType,
    required String requestPayload,
    required String status,
    String? resolutionNote,
    int? reviewedByUserId,
    DateTime? reviewedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DataChangeRequestImpl;

  factory DataChangeRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return DataChangeRequest(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      requesterUserId: jsonSerialization['requesterUserId'] as int,
      targetChildId: jsonSerialization['targetChildId'] as int?,
      requestType: jsonSerialization['requestType'] as String,
      requestPayload: jsonSerialization['requestPayload'] as String,
      status: jsonSerialization['status'] as String,
      resolutionNote: jsonSerialization['resolutionNote'] as String?,
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as int?,
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DataChangeRequestTable();

  static const db = DataChangeRequestRepository._();

  @override
  int? id;

  int organizationId;

  int requesterUserId;

  int? targetChildId;

  String requestType;

  String requestPayload;

  String status;

  String? resolutionNote;

  int? reviewedByUserId;

  DateTime? reviewedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DataChangeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DataChangeRequest copyWith({
    int? id,
    int? organizationId,
    int? requesterUserId,
    int? targetChildId,
    String? requestType,
    String? requestPayload,
    String? status,
    String? resolutionNote,
    int? reviewedByUserId,
    DateTime? reviewedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'requesterUserId': requesterUserId,
      if (targetChildId != null) 'targetChildId': targetChildId,
      'requestType': requestType,
      'requestPayload': requestPayload,
      'status': status,
      if (resolutionNote != null) 'resolutionNote': resolutionNote,
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'requesterUserId': requesterUserId,
      if (targetChildId != null) 'targetChildId': targetChildId,
      'requestType': requestType,
      'requestPayload': requestPayload,
      'status': status,
      if (resolutionNote != null) 'resolutionNote': resolutionNote,
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DataChangeRequestInclude include() {
    return DataChangeRequestInclude._();
  }

  static DataChangeRequestIncludeList includeList({
    _i1.WhereExpressionBuilder<DataChangeRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DataChangeRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DataChangeRequestTable>? orderByList,
    DataChangeRequestInclude? include,
  }) {
    return DataChangeRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DataChangeRequest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DataChangeRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DataChangeRequestImpl extends DataChangeRequest {
  _DataChangeRequestImpl({
    int? id,
    required int organizationId,
    required int requesterUserId,
    int? targetChildId,
    required String requestType,
    required String requestPayload,
    required String status,
    String? resolutionNote,
    int? reviewedByUserId,
    DateTime? reviewedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          requesterUserId: requesterUserId,
          targetChildId: targetChildId,
          requestType: requestType,
          requestPayload: requestPayload,
          status: status,
          resolutionNote: resolutionNote,
          reviewedByUserId: reviewedByUserId,
          reviewedAt: reviewedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [DataChangeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DataChangeRequest copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? requesterUserId,
    Object? targetChildId = _Undefined,
    String? requestType,
    String? requestPayload,
    String? status,
    Object? resolutionNote = _Undefined,
    Object? reviewedByUserId = _Undefined,
    Object? reviewedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DataChangeRequest(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      requesterUserId: requesterUserId ?? this.requesterUserId,
      targetChildId: targetChildId is int? ? targetChildId : this.targetChildId,
      requestType: requestType ?? this.requestType,
      requestPayload: requestPayload ?? this.requestPayload,
      status: status ?? this.status,
      resolutionNote:
          resolutionNote is String? ? resolutionNote : this.resolutionNote,
      reviewedByUserId:
          reviewedByUserId is int? ? reviewedByUserId : this.reviewedByUserId,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DataChangeRequestTable extends _i1.Table<int?> {
  DataChangeRequestTable({super.tableRelation})
      : super(tableName: 'data_change_request') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    requesterUserId = _i1.ColumnInt(
      'requesterUserId',
      this,
    );
    targetChildId = _i1.ColumnInt(
      'targetChildId',
      this,
    );
    requestType = _i1.ColumnString(
      'requestType',
      this,
    );
    requestPayload = _i1.ColumnString(
      'requestPayload',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    resolutionNote = _i1.ColumnString(
      'resolutionNote',
      this,
    );
    reviewedByUserId = _i1.ColumnInt(
      'reviewedByUserId',
      this,
    );
    reviewedAt = _i1.ColumnDateTime(
      'reviewedAt',
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
  }

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnInt requesterUserId;

  late final _i1.ColumnInt targetChildId;

  late final _i1.ColumnString requestType;

  late final _i1.ColumnString requestPayload;

  late final _i1.ColumnString status;

  late final _i1.ColumnString resolutionNote;

  late final _i1.ColumnInt reviewedByUserId;

  late final _i1.ColumnDateTime reviewedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        requesterUserId,
        targetChildId,
        requestType,
        requestPayload,
        status,
        resolutionNote,
        reviewedByUserId,
        reviewedAt,
        createdAt,
        updatedAt,
      ];
}

class DataChangeRequestInclude extends _i1.IncludeObject {
  DataChangeRequestInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DataChangeRequest.t;
}

class DataChangeRequestIncludeList extends _i1.IncludeList {
  DataChangeRequestIncludeList._({
    _i1.WhereExpressionBuilder<DataChangeRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DataChangeRequest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DataChangeRequest.t;
}

class DataChangeRequestRepository {
  const DataChangeRequestRepository._();

  /// Returns a list of [DataChangeRequest]s matching the given query parameters.
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
  Future<List<DataChangeRequest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DataChangeRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DataChangeRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DataChangeRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DataChangeRequest>(
      where: where?.call(DataChangeRequest.t),
      orderBy: orderBy?.call(DataChangeRequest.t),
      orderByList: orderByList?.call(DataChangeRequest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DataChangeRequest] matching the given query parameters.
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
  Future<DataChangeRequest?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DataChangeRequestTable>? where,
    int? offset,
    _i1.OrderByBuilder<DataChangeRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DataChangeRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DataChangeRequest>(
      where: where?.call(DataChangeRequest.t),
      orderBy: orderBy?.call(DataChangeRequest.t),
      orderByList: orderByList?.call(DataChangeRequest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DataChangeRequest] by its [id] or null if no such row exists.
  Future<DataChangeRequest?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DataChangeRequest>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DataChangeRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [DataChangeRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DataChangeRequest>> insert(
    _i1.Session session,
    List<DataChangeRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DataChangeRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DataChangeRequest] and returns the inserted row.
  ///
  /// The returned [DataChangeRequest] will have its `id` field set.
  Future<DataChangeRequest> insertRow(
    _i1.Session session,
    DataChangeRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DataChangeRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DataChangeRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DataChangeRequest>> update(
    _i1.Session session,
    List<DataChangeRequest> rows, {
    _i1.ColumnSelections<DataChangeRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DataChangeRequest>(
      rows,
      columns: columns?.call(DataChangeRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DataChangeRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DataChangeRequest> updateRow(
    _i1.Session session,
    DataChangeRequest row, {
    _i1.ColumnSelections<DataChangeRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DataChangeRequest>(
      row,
      columns: columns?.call(DataChangeRequest.t),
      transaction: transaction,
    );
  }

  /// Deletes all [DataChangeRequest]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DataChangeRequest>> delete(
    _i1.Session session,
    List<DataChangeRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DataChangeRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DataChangeRequest].
  Future<DataChangeRequest> deleteRow(
    _i1.Session session,
    DataChangeRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DataChangeRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DataChangeRequest>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DataChangeRequestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DataChangeRequest>(
      where: where(DataChangeRequest.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DataChangeRequestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DataChangeRequest>(
      where: where?.call(DataChangeRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
