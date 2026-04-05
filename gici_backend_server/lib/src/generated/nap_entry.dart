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

abstract class NapEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  NapEntry._({
    this.id,
    required this.organizationId,
    required this.childId,
    required this.recordedByUserId,
    required this.startedAt,
    this.endedAt,
    this.durationMinutes,
    this.sleepQuality,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NapEntry({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NapEntryImpl;

  factory NapEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return NapEntry(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      childId: jsonSerialization['childId'] as int,
      recordedByUserId: jsonSerialization['recordedByUserId'] as int,
      startedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      sleepQuality: jsonSerialization['sleepQuality'] as String?,
      notes: jsonSerialization['notes'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = NapEntryTable();

  static const db = NapEntryRepository._();

  @override
  int? id;

  int organizationId;

  int childId;

  int recordedByUserId;

  DateTime startedAt;

  DateTime? endedAt;

  int? durationMinutes;

  String? sleepQuality;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [NapEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NapEntry copyWith({
    int? id,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'recordedByUserId': recordedByUserId,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (sleepQuality != null) 'sleepQuality': sleepQuality,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      'childId': childId,
      'recordedByUserId': recordedByUserId,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (sleepQuality != null) 'sleepQuality': sleepQuality,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static NapEntryInclude include() {
    return NapEntryInclude._();
  }

  static NapEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<NapEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NapEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NapEntryTable>? orderByList,
    NapEntryInclude? include,
  }) {
    return NapEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NapEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(NapEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NapEntryImpl extends NapEntry {
  _NapEntryImpl({
    int? id,
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          childId: childId,
          recordedByUserId: recordedByUserId,
          startedAt: startedAt,
          endedAt: endedAt,
          durationMinutes: durationMinutes,
          sleepQuality: sleepQuality,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [NapEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NapEntry copyWith({
    Object? id = _Undefined,
    int? organizationId,
    int? childId,
    int? recordedByUserId,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? durationMinutes = _Undefined,
    Object? sleepQuality = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NapEntry(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      childId: childId ?? this.childId,
      recordedByUserId: recordedByUserId ?? this.recordedByUserId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      durationMinutes:
          durationMinutes is int? ? durationMinutes : this.durationMinutes,
      sleepQuality: sleepQuality is String? ? sleepQuality : this.sleepQuality,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NapEntryTable extends _i1.Table<int?> {
  NapEntryTable({super.tableRelation}) : super(tableName: 'nap_entry') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    childId = _i1.ColumnInt(
      'childId',
      this,
    );
    recordedByUserId = _i1.ColumnInt(
      'recordedByUserId',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    endedAt = _i1.ColumnDateTime(
      'endedAt',
      this,
    );
    durationMinutes = _i1.ColumnInt(
      'durationMinutes',
      this,
    );
    sleepQuality = _i1.ColumnString(
      'sleepQuality',
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

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnInt childId;

  late final _i1.ColumnInt recordedByUserId;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime endedAt;

  late final _i1.ColumnInt durationMinutes;

  late final _i1.ColumnString sleepQuality;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        childId,
        recordedByUserId,
        startedAt,
        endedAt,
        durationMinutes,
        sleepQuality,
        notes,
        createdAt,
        updatedAt,
      ];
}

class NapEntryInclude extends _i1.IncludeObject {
  NapEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => NapEntry.t;
}

class NapEntryIncludeList extends _i1.IncludeList {
  NapEntryIncludeList._({
    _i1.WhereExpressionBuilder<NapEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NapEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => NapEntry.t;
}

class NapEntryRepository {
  const NapEntryRepository._();

  /// Returns a list of [NapEntry]s matching the given query parameters.
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
  Future<List<NapEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NapEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NapEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NapEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<NapEntry>(
      where: where?.call(NapEntry.t),
      orderBy: orderBy?.call(NapEntry.t),
      orderByList: orderByList?.call(NapEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [NapEntry] matching the given query parameters.
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
  Future<NapEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NapEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<NapEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NapEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<NapEntry>(
      where: where?.call(NapEntry.t),
      orderBy: orderBy?.call(NapEntry.t),
      orderByList: orderByList?.call(NapEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [NapEntry] by its [id] or null if no such row exists.
  Future<NapEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<NapEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [NapEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [NapEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<NapEntry>> insert(
    _i1.Session session,
    List<NapEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<NapEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [NapEntry] and returns the inserted row.
  ///
  /// The returned [NapEntry] will have its `id` field set.
  Future<NapEntry> insertRow(
    _i1.Session session,
    NapEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<NapEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [NapEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<NapEntry>> update(
    _i1.Session session,
    List<NapEntry> rows, {
    _i1.ColumnSelections<NapEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<NapEntry>(
      rows,
      columns: columns?.call(NapEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NapEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NapEntry> updateRow(
    _i1.Session session,
    NapEntry row, {
    _i1.ColumnSelections<NapEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<NapEntry>(
      row,
      columns: columns?.call(NapEntry.t),
      transaction: transaction,
    );
  }

  /// Deletes all [NapEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<NapEntry>> delete(
    _i1.Session session,
    List<NapEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<NapEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [NapEntry].
  Future<NapEntry> deleteRow(
    _i1.Session session,
    NapEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NapEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<NapEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NapEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<NapEntry>(
      where: where(NapEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NapEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<NapEntry>(
      where: where?.call(NapEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
