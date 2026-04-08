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

abstract class Absence
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Absence._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.date,
    this.reason,
    required this.isJustified,
    required this.reportedByUserId,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Absence({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required DateTime date,
    String? reason,
    required bool isJustified,
    required _i1.UuidValue reportedByUserId,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AbsenceImpl;

  factory Absence.fromJson(Map<String, dynamic> jsonSerialization) {
    return Absence(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      reason: jsonSerialization['reason'] as String?,
      isJustified: jsonSerialization['isJustified'] as bool,
      reportedByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['reportedByUserId']),
      notes: jsonSerialization['notes'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = AbsenceTable();

  static const db = AbsenceRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i1.UuidValue childId;

  DateTime date;

  String? reason;

  bool isJustified;

  _i1.UuidValue reportedByUserId;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Absence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Absence copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    DateTime? date,
    String? reason,
    bool? isJustified,
    _i1.UuidValue? reportedByUserId,
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
      'date': date.toJson(),
      if (reason != null) 'reason': reason,
      'isJustified': isJustified,
      'reportedByUserId': reportedByUserId.toJson(),
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
      'date': date.toJson(),
      if (reason != null) 'reason': reason,
      'isJustified': isJustified,
      'reportedByUserId': reportedByUserId.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AbsenceInclude include() {
    return AbsenceInclude._();
  }

  static AbsenceIncludeList includeList({
    _i1.WhereExpressionBuilder<AbsenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AbsenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AbsenceTable>? orderByList,
    AbsenceInclude? include,
  }) {
    return AbsenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Absence.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Absence.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AbsenceImpl extends Absence {
  _AbsenceImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required _i1.UuidValue childId,
    required DateTime date,
    String? reason,
    required bool isJustified,
    required _i1.UuidValue reportedByUserId,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          date: date,
          reason: reason,
          isJustified: isJustified,
          reportedByUserId: reportedByUserId,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Absence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Absence copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    _i1.UuidValue? childId,
    DateTime? date,
    Object? reason = _Undefined,
    bool? isJustified,
    _i1.UuidValue? reportedByUserId,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Absence(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      date: date ?? this.date,
      reason: reason is String? ? reason : this.reason,
      isJustified: isJustified ?? this.isJustified,
      reportedByUserId: reportedByUserId ?? this.reportedByUserId,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AbsenceTable extends _i1.Table<_i1.UuidValue?> {
  AbsenceTable({super.tableRelation}) : super(tableName: 'absence') {
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    childId = _i1.ColumnUuid(
      'childId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    isJustified = _i1.ColumnBool(
      'isJustified',
      this,
    );
    reportedByUserId = _i1.ColumnUuid(
      'reportedByUserId',
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

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnString reason;

  late final _i1.ColumnBool isJustified;

  late final _i1.ColumnUuid reportedByUserId;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        date,
        reason,
        isJustified,
        reportedByUserId,
        notes,
        createdAt,
        updatedAt,
      ];
}

class AbsenceInclude extends _i1.IncludeObject {
  AbsenceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Absence.t;
}

class AbsenceIncludeList extends _i1.IncludeList {
  AbsenceIncludeList._({
    _i1.WhereExpressionBuilder<AbsenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Absence.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Absence.t;
}

class AbsenceRepository {
  const AbsenceRepository._();

  /// Returns a list of [Absence]s matching the given query parameters.
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
  Future<List<Absence>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AbsenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AbsenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AbsenceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Absence>(
      where: where?.call(Absence.t),
      orderBy: orderBy?.call(Absence.t),
      orderByList: orderByList?.call(Absence.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Absence] matching the given query parameters.
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
  Future<Absence?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AbsenceTable>? where,
    int? offset,
    _i1.OrderByBuilder<AbsenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AbsenceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Absence>(
      where: where?.call(Absence.t),
      orderBy: orderBy?.call(Absence.t),
      orderByList: orderByList?.call(Absence.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Absence] by its [id] or null if no such row exists.
  Future<Absence?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Absence>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Absence]s in the list and returns the inserted rows.
  ///
  /// The returned [Absence]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Absence>> insert(
    _i1.Session session,
    List<Absence> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Absence>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Absence] and returns the inserted row.
  ///
  /// The returned [Absence] will have its `id` field set.
  Future<Absence> insertRow(
    _i1.Session session,
    Absence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Absence>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Absence]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Absence>> update(
    _i1.Session session,
    List<Absence> rows, {
    _i1.ColumnSelections<AbsenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Absence>(
      rows,
      columns: columns?.call(Absence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Absence]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Absence> updateRow(
    _i1.Session session,
    Absence row, {
    _i1.ColumnSelections<AbsenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Absence>(
      row,
      columns: columns?.call(Absence.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Absence]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Absence>> delete(
    _i1.Session session,
    List<Absence> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Absence>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Absence].
  Future<Absence> deleteRow(
    _i1.Session session,
    Absence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Absence>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Absence>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AbsenceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Absence>(
      where: where(Absence.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AbsenceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Absence>(
      where: where?.call(Absence.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
