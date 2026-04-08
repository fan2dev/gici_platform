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

abstract class ChildTariffAssignment
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ChildTariffAssignment._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.tariffId,
    required this.startDate,
    this.endDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChildTariffAssignment({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue tariffId,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChildTariffAssignmentImpl;

  factory ChildTariffAssignment.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChildTariffAssignment(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      tariffId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['tariffId']),
      startDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      notes: jsonSerialization['notes'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChildTariffAssignmentTable();

  static const db = ChildTariffAssignmentRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue childId;

  _i1.UuidValue tariffId;

  DateTime startDate;

  DateTime? endDate;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ChildTariffAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChildTariffAssignment copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? tariffId,
    DateTime? startDate,
    DateTime? endDate,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'childId': childId.toJson(),
      'tariffId': tariffId.toJson(),
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'childId': childId.toJson(),
      'tariffId': tariffId.toJson(),
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChildTariffAssignmentInclude include() {
    return ChildTariffAssignmentInclude._();
  }

  static ChildTariffAssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<ChildTariffAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildTariffAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildTariffAssignmentTable>? orderByList,
    ChildTariffAssignmentInclude? include,
  }) {
    return ChildTariffAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChildTariffAssignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChildTariffAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChildTariffAssignmentImpl extends ChildTariffAssignment {
  _ChildTariffAssignmentImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required _i1.UuidValue tariffId,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          tariffId: tariffId,
          startDate: startDate,
          endDate: endDate,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ChildTariffAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChildTariffAssignment copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    _i1.UuidValue? tariffId,
    DateTime? startDate,
    Object? endDate = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChildTariffAssignment(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      tariffId: tariffId ?? this.tariffId,
      startDate: startDate ?? this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChildTariffAssignmentTable extends _i1.Table<_i1.UuidValue?> {
  ChildTariffAssignmentTable({super.tableRelation})
      : super(tableName: 'child_tariff_assignment') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    childId = _i1.ColumnUuid(
      'childId',
      this,
    );
    tariffId = _i1.ColumnUuid(
      'tariffId',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
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

  late final _i1.ColumnUuid organizationId;

  late final _i1.ColumnUuid childId;

  late final _i1.ColumnUuid tariffId;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        tariffId,
        startDate,
        endDate,
        notes,
        createdAt,
        updatedAt,
      ];
}

class ChildTariffAssignmentInclude extends _i1.IncludeObject {
  ChildTariffAssignmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ChildTariffAssignment.t;
}

class ChildTariffAssignmentIncludeList extends _i1.IncludeList {
  ChildTariffAssignmentIncludeList._({
    _i1.WhereExpressionBuilder<ChildTariffAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChildTariffAssignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ChildTariffAssignment.t;
}

class ChildTariffAssignmentRepository {
  const ChildTariffAssignmentRepository._();

  /// Returns a list of [ChildTariffAssignment]s matching the given query parameters.
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
  Future<List<ChildTariffAssignment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildTariffAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChildTariffAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildTariffAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ChildTariffAssignment>(
      where: where?.call(ChildTariffAssignment.t),
      orderBy: orderBy?.call(ChildTariffAssignment.t),
      orderByList: orderByList?.call(ChildTariffAssignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ChildTariffAssignment] matching the given query parameters.
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
  Future<ChildTariffAssignment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildTariffAssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChildTariffAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChildTariffAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ChildTariffAssignment>(
      where: where?.call(ChildTariffAssignment.t),
      orderBy: orderBy?.call(ChildTariffAssignment.t),
      orderByList: orderByList?.call(ChildTariffAssignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ChildTariffAssignment] by its [id] or null if no such row exists.
  Future<ChildTariffAssignment?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ChildTariffAssignment>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ChildTariffAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [ChildTariffAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChildTariffAssignment>> insert(
    _i1.Session session,
    List<ChildTariffAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChildTariffAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChildTariffAssignment] and returns the inserted row.
  ///
  /// The returned [ChildTariffAssignment] will have its `id` field set.
  Future<ChildTariffAssignment> insertRow(
    _i1.Session session,
    ChildTariffAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChildTariffAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChildTariffAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChildTariffAssignment>> update(
    _i1.Session session,
    List<ChildTariffAssignment> rows, {
    _i1.ColumnSelections<ChildTariffAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChildTariffAssignment>(
      rows,
      columns: columns?.call(ChildTariffAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChildTariffAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChildTariffAssignment> updateRow(
    _i1.Session session,
    ChildTariffAssignment row, {
    _i1.ColumnSelections<ChildTariffAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChildTariffAssignment>(
      row,
      columns: columns?.call(ChildTariffAssignment.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ChildTariffAssignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChildTariffAssignment>> delete(
    _i1.Session session,
    List<ChildTariffAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChildTariffAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChildTariffAssignment].
  Future<ChildTariffAssignment> deleteRow(
    _i1.Session session,
    ChildTariffAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChildTariffAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChildTariffAssignment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChildTariffAssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChildTariffAssignment>(
      where: where(ChildTariffAssignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChildTariffAssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChildTariffAssignment>(
      where: where?.call(ChildTariffAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
